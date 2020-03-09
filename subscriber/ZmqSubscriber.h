#pragma once

#include "Subscriber.h"

#include <zmq.hpp>

namespace net {

class ZmqSubscriber : public Subscriber
{
public:
    ZmqSubscriber(zmq::context_t &context, const std::string_view host, const uint16_t port);

    void subscribeTo(const std::string &topic) override;
    void subscribeToAllTopics() override;

    std::string waitForNotification() override;

private:
    zmq::socket_t m_subscriber;
};

} // namespace net