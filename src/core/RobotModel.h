#pragma once

#include <string>
#include <vector>

#include "DhLink.h"

// имя, звенья и начальные углы
class RobotModel
{
public:
    RobotModel(std::string name, std::vector<DhLink> links, std::vector<double> initialAnglesRad);
    const std::string &name() const { return m_name; }
    int jointCount() const { return static_cast<int>(m_links.size()); }
    const DhLink &link(int index) const { return m_links[index]; }
    const std::vector<double> &initialAnglesRad() const { return m_initialAnglesRad; }

private:
    std::string m_name;
    std::vector<DhLink> m_links;
    std::vector<double> m_initialAnglesRad;
};
