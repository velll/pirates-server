worker_processes 5
@app_path = __dir__

listen '0.0.0.0:8080', :backlog => 64
pid "#{@app_path}/unicorn.pid"