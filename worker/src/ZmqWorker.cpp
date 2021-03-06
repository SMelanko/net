#include "ZmqWorker.h"

#include <Log.h>

#include <zhelpers.hpp>

namespace net {

ZmqWorker::ZmqWorker(zmq::context_t& context, std::string_view host, const uint16_t port)
  : m_socket{ context, ZMQ_REP }
{
  const std::string address = fmt::format("tcp://{}:{}", host, port);
  Log::info("Worker is connecting to {}", address);
  m_socket.connect(address);
  Log::info("OK, worker is ready");
}

ZmqWorker::ZmqWorker(zmq::context_t& context, const uint16_t port)
  : ZmqWorker{ context, "localhost", port }
{}

void ZmqWorker::process()
{
  const std::string message = s_recv(m_socket);

  // Do some "work"
  // sleep(1);

  s_send(m_socket, message);
}

} // namespace net
