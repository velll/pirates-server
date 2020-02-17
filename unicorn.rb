worker_processes 5
@app_path = __dir__

if ENV['UNICORN_LISTEN'].nil?
  raise RuntimeError, 'Tell me where to listen! Like, UNICORN_LISTEN=127.0.0.1:8080 or something' 
end

listen ENV['UNICORN_LISTEN'], :backlog => 64
pid "#{@app_path}/unicorn.pid"