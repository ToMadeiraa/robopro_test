#pragma once

#include <QAbstractListModel>
#include <QStringList>
#include <QVector>

#include "core/RobotModel.h"

// список сочленений для QML
class JointListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Role
    {
        NameRole = Qt::UserRole + 1,
        AngleRole
    };

    explicit JointListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    // заполняет модель звеньями и углами
    void reset(const RobotModel &model, const std::vector<double> &anglesRad);
    // обновляет угол одной строки
    void setAngle(int row, double degrees);

private:
    QStringList m_names;
    QVector<double> m_anglesDeg;
};
