class Service < ActiveRecord::Base
  include Net
  attr_accessible :description, :expectation, :last_poll, :name, :poll_interval, :uri, :valid, :api_format, :user_agent, :cookies
  has_many :polls, :dependent => :destroy

  def poll_webservice
    poll = Poll.new
    poll.response = get_response
    poll.response_time = poll.response[:avg_time]
    poll.response_text = poll.response[:body]
    poll.healthy = (poll.response_time > 0 && poll.response[:valid])
    poll.save
    @polls << poll
  end

  def get_response
    response = {}
    response[:avg_time] = get_avg_response_time
    response[:body] = HTTParty.get(@uri).body
    response[:valid] = validate_response(response[:body], @expectation)
    return response
  end

  def get_avg_response_time
    service_uri = URI.parse(@uri)
    pings = []
    5.times do |i|
      before_time = Time.now
      begin
        http = Net::HTTP.new(service_uri.host, service_uri.port)
        http.read_timeout = 2
        if @uri.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        response, data = http.request(Net::HTTP::Get.new(uri.request_uri, request_headers))
      rescue Timeout::Error => e
        pings[i] = -1
      end
      pings[i] = (Time.now - before_time) * 1000
    end
    pings.delete_if { |p| p < 1 }
    if pings.length > 0
      return (pings.reduce(:+) / pings.length)
    else
      return 0
  end

  # TODO: Make this method smarter
  def validate_response(response, expectation)
    response.to_s.include? expectation
  end 

  def request_headers
    header = {}
    header['User-Agent'] = @user_agent or 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3'
    header['Cookies'] = @cookies if @cookies
    return header
  end
end
