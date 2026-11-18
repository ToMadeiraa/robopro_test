#include "ForwardKinematics.h"

#include "Matrix4.h"

std::vector<Vector3> ForwardKinematics::solve(const RobotModel &model, const std::vector<double> &anglesRad)
{
    std::vector<Vector3> points;
    points.reserve(static_cast<std::size_t>(model.jointCount()) + 1);

    Matrix4 frame;
    points.push_back(frame.translation());

    for (int i = 0; i < model.jointCount(); ++i) {
        const DhLink &link = model.link(i);
        frame = frame * Matrix4::fromDh(anglesRad[i], link.d(), link.a(), link.alphaRad());
        points.push_back(frame.translation());
    }

    return points;
}
