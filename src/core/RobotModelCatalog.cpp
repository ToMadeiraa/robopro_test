#include "RobotModelCatalog.h"

RobotModelCatalog::RobotModelCatalog()
{
    const double kPi = 3.14159265358979323846;
    const double deg = kPi / 180.0;

    m_models.push_back(RobotModel(
        "RB-6A",
        {
            DhLink(0.0, 0.200, 90.0 * deg),
            DhLink(-0.500, 0.130, 0.0),
            DhLink(-0.450, -0.150, 0.0),
            DhLink(0.0, 0.200, 90.0 * deg),
            DhLink(0.0, 0.230, -90.0 * deg),
            DhLink(0.0, 0.200, 0.0),
        },
        {12.0 * deg, 30.0 * deg, -45.0 * deg, 20.0 * deg, 60.0 * deg, 10.0 * deg}));

    m_models.push_back(RobotModel(
        "RB-6B",
        {
            DhLink(0.0, 0.185, 90.0 * deg),
            DhLink(-0.600, 0.120, 0.0),
            DhLink(-0.420, -0.140, 0.0),
            DhLink(0.0, 0.190, 90.0 * deg),
            DhLink(0.0, 0.220, -90.0 * deg),
            DhLink(0.0, 0.180, 0.0),
        },
        {15.0 * deg, -40.0 * deg, 55.0 * deg, -20.0 * deg, 70.0 * deg, 35.0 * deg}));

    m_models.push_back(RobotModel(
        "RB-6C",
        {
            DhLink(0.0, 0.250, 90.0 * deg),
            DhLink(-0.700, 0.150, 0.0),
            DhLink(-0.500, -0.160, 0.0),
            DhLink(0.0, 0.220, 90.0 * deg),
            DhLink(0.0, 0.250, -90.0 * deg),
            DhLink(0.0, 0.220, 0.0),
        },
        {-10.0 * deg, 40.0 * deg, -25.0 * deg, 45.0 * deg, -30.0 * deg, 0.0}));
}
