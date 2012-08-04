class Service < ActiveRecord::Base
  include Net
  attr_accessible :description, :expectation, :name, :poll_interval, :uri, :api_format, :user_agent, :cookies
  has_many :polls, :dependent => :destroy

  def poll_webservice
    poll = Poll.new
    poll.response = get_response
    poll.response_time = poll.response[:avg_time]
    poll.response_text = poll.response[:body]
    poll.healthy = (poll.response_time > 0 && poll.response[:valid])
    poll.save
    self.polls << poll
  end

  def get_response
    response = {}
    response[:avg_time] = get_avg_response_time
    response[:body] = HTTParty.get(self.uri).body
    response[:valid] = validate_response(response[:body], self.expectation)
    return response
  end

  def get_avg_response_time
    service_uri = URI.parse(self.uri)
    pings = []
    5.times do |i|
      before_time = Time.now
      begin
        http = Net::HTTP.new(service_uri.host, service_uri.port)
        http.open_timeout = 1 
        http.read_timeout = 2
        if service_uri.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        response, data = http.request(Net::HTTP::Get.new(service_uri.request_uri, request_headers))
        pings[i] = (Time.now - before_time) * 1000
      rescue Timeout::Error => e
        pings[i] = -1
      rescue SocketError => e
        return 0
      end
    end
    pings.delete_if { |p| p < 1 }    
    if pings.length > 0
      return (pings.reduce(:+) / pings.length)
    else
      return 0
    end
  end

  # TODO: Make this method smarter
  def validate_response(response, expectation)
    response.to_s.include? expectation
  end 

  def request_headers
    header = {}
    header['User-Agent'] = self.user_agent || 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3'
    header['Cookies'] = self.cookies if self.cookies
    return header
  end
end
