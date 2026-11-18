#pragma once

#include <vector>

#include "RobotModel.h"

class RobotModelCatalog
{
public:
    RobotModelCatalog();

    int count() const { return static_cast<int>(m_models.size()); }
    const RobotModel &model(int index) const { return m_models[index]; }

private:
    std::vector<RobotModel> m_models;
};
