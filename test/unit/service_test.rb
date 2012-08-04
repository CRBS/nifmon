require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test "should report average response time" do
    service = services(:federation_query)
    time = service.get_avg_response_time
    assert (time > 0), "Did not return a valid response time for federation_query. Output: #{time}"
  end

  test "avg_response_time should return 0 if unable to open connection to host" do
    service = services(:nxdomain)
    time = service.get_avg_response_time
    assert (time == 0), "Returned #{time} instead of 0 for a non-existent URI."
  end

  test "avg_response_time should return 0 if connection times out" do
    service = services(:noweb)
    time = service.get_avg_response_time
    assert (time == 0), "Return #{time} instead of 0 for a downed web service."
  end

  test "poll_webservice should create a new Poll if successful" do
    service = services(:federation_query)
    before_polls = service.polls.size
    service.poll_webservice
    assert (service.polls.size == before_polls + 1), "poll_webservice did not create a new Poll"
  end

  test "response should not be valid if expectation fails" do
    service = services(:bad_expectation)
    r = service.get_response
    assert !r[:valid], "Response was valid even with a failed expectation. Response: #{r[:body]}"
  end
end
