namespace :poll do
  desc "poll all webservices"
  task :services => :environment do
    Service.all.each do |s|
      s.poll_webservice
    end
  end
end