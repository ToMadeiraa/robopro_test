#include "RobotController.h"

#include "JointListModel.h"

RobotController::RobotController(QObject *parent)
    : QObject(parent)
    , m_model(m_catalog.model(0))
    , m_anglesRad(m_model.initialAnglesRad())
    , m_jointModel(new JointListModel(this))
{
    m_jointModel->reset(m_model, m_anglesRad);
    rebuildPose();
}

QStringList RobotController::modelNames() const
{
    QStringList names;
    names.reserve(m_catalog.count());

    for (int i = 0; i < m_catalog.count(); ++i)
        names.append(QString::fromStdString(m_catalog.model(i).name()));

    return names;
}

void RobotController::setCurrentModelIndex(int index)
{
    if (index < 0 || index >= m_catalog.count() || index == m_currentModelIndex)
        return;

    m_currentModelIndex = index;
    selectModel(index);
    emit currentModelIndexChanged();
}

QAbstractItemModel *RobotController::joints()
{
    return m_jointModel;
}

QVector3D RobotController::tcpPosition() const
{
    return QVector3D(static_cast<float>(m_tcp.x()),
                     static_cast<float>(m_tcp.y()),
                     static_cast<float>(m_tcp.z()));
}

QVariantList RobotController::framePoints() const
{
    QVariantList points;
    points.reserve(static_cast<int>(m_points.size()));

    for (const Vector3 &point : m_points)
        points.append(toScene(point));

    return points;
}

void RobotController::setJointAngle(int index, double degrees)
{
    if (index < 0 || index >= m_model.jointCount())
        return;

    const double kPi = 3.14159265358979323846;

    m_anglesRad[index] = degrees * kPi / 180.0;
    m_jointModel->setAngle(index, degrees);
    rebuildPose();
}

void RobotController::selectModel(int index)
{
    m_model = m_catalog.model(index);
    m_anglesRad = m_model.initialAnglesRad();
    m_jointModel->reset(m_model, m_anglesRad);
    rebuildPose();
}

void RobotController::rebuildPose()
{
    m_points = ForwardKinematics::solve(m_model, m_anglesRad);
    m_tcp = m_points.back();
    emit poseChanged();
}

QVector3D RobotController::toScene(const Vector3 &point) const
{
    return QVector3D(static_cast<float>(point.x()),
                     static_cast<float>(point.z()),
                     static_cast<float>(-point.y()));
}
