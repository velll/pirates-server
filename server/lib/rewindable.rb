module Rewindable
  def with_rewind
    body = request.body.read

    yield body

    request.body.rewind
  end
end
