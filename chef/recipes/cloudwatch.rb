package 'cloudwatch_dependencies' do
  package_name %w(libwww-perl libdatetime-perl)
end

ark 'cloudwatchscripts' do
  action :put
  path '/usr/local/lib'
  url 'http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip'
end

%w(
  mon-get-instance-stats.pl
  mon-put-instance-data.pl
).each do |script|
  file ::File.join('/usr/local/lib/cloudwatchscripts', script) do
    mode 0755
  end
end

cron_d 'cloudwatch-memory-disk-utilization-metrics' do
  minute  5
  command '/usr/local/lib/cloudwatchscripts/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron'
end
