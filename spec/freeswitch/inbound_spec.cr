require "../spec_helper"

describe Alice::Freeswitch::ESL::Inbound do
  it "should login to the FS ESL" do
    esl = Alice::Freeswitch::ESL::Inbound.new \
      host: ENV.fetch("FS_ESL_HOST", "localhost"),
      port: ENV.fetch("FS_ESL_PORT", "8021"),
      auth: ENV.fetch("FS_ESL_PASSWORD", "ClueCon")
    esl.connect
    sleep 10
  end
end
