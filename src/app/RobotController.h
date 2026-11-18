#pragma once

#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QVector3D>

#include <vector>

#include "core/ForwardKinematics.h"
#include "core/RobotModel.h"
#include "core/RobotModelCatalog.h"

class JointListModel;
class QAbstractItemModel;

// управляет моделью и данными для QML
class RobotController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList modelNames READ modelNames CONSTANT)
    Q_PROPERTY(int currentModelIndex READ currentModelIndex WRITE setCurrentModelIndex NOTIFY currentModelIndexChanged)
    Q_PROPERTY(QAbstractItemModel *joints READ joints CONSTANT)
    Q_PROPERTY(QVector3D tcpPosition READ tcpPosition NOTIFY poseChanged)
    Q_PROPERTY(QVariantList framePoints READ framePoints NOTIFY poseChanged)

public:
    // создаёт контроллер с моделью RB6A
    explicit RobotController(QObject *parent = nullptr);

    QStringList modelNames() const;
    int currentModelIndex() const { return m_currentModelIndex; }
    void setCurrentModelIndex(int index);
    QAbstractItemModel *joints();
    QVector3D tcpPosition() const;
    // возвращает точки звеньев в координатах сцены
    QVariantList framePoints() const;

public slots:
    // задаёт угол сочленения в градусах
    void setJointAngle(int index, double degrees);

signals:
    void currentModelIndexChanged();
    void poseChanged();

private:
    // применяет модель и сбрасывает углы
    void selectModel(int index);
    // пересчитывает точки и TCP
    void rebuildPose();
    // переводит точку из DH в координаты сцены
    QVector3D toScene(const Vector3 &point) const;

    RobotModelCatalog m_catalog;
    RobotModel m_model;
    std::vector<double> m_anglesRad;
    std::vector<Vector3> m_points;
    Vector3 m_tcp;
    JointListModel *m_jointModel; // модель сочленений для QML
    int m_currentModelIndex = 0;
};
