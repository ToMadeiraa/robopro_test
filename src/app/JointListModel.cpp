#include "JointListModel.h"

JointListModel::JointListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int JointListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return static_cast<int>(m_names.size());
}

QVariant JointListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_anglesDeg.size())
        return QVariant();

    if (role == NameRole)
        return m_names.at(index.row());

    if (role == AngleRole)
        return m_anglesDeg.at(index.row());

    return QVariant();
}

QHash<int, QByteArray> JointListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(NameRole, QByteArrayLiteral("jointName"));
    roles.insert(AngleRole, QByteArrayLiteral("angleDeg"));
    return roles;
}

void JointListModel::reset(const RobotModel &model, const std::vector<double> &anglesRad)
{
    beginResetModel();
    m_names.clear();
    m_anglesDeg.clear();

    const double kPi = 3.14159265358979323846;

    for (int i = 0; i < model.jointCount(); ++i) {
        m_names.append(QStringLiteral("Угол соединения %1").arg(i + 1));
        m_anglesDeg.append(anglesRad[i] * 180.0 / kPi);
    }

    endResetModel();
}

void JointListModel::setAngle(int row, double degrees)
{
    if (row < 0 || row >= m_anglesDeg.size())
        return;

    m_anglesDeg[row] = degrees;

    const QModelIndex changed = index(row, 0);
    emit dataChanged(changed, changed, QVector<int>{AngleRole});
}
