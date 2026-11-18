#pragma once

#include <vector>

#include "RobotModel.h"
#include "Vector3.h"

class ForwardKinematics
{
public:
    // статический класс
    ForwardKinematics() = delete;

    // возвращает N+1 точек. базу и начала систем координат
    static std::vector<Vector3> solve(const RobotModel &model, const std::vector<double> &anglesRad);
};
