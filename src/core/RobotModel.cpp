#include "RobotModel.h"

#include <utility>

RobotModel::RobotModel(std::string name, std::vector<DhLink> links, std::vector<double> initialAnglesRad)
    : m_name(std::move(name))
    , m_links(std::move(links))
    , m_initialAnglesRad(std::move(initialAnglesRad))
{
}
