#pragma once

class Vector3
{
public:
    // создаёт нулевой вектор
    Vector3() = default;

    Vector3(double x, double y, double z)
        : m_x(x)
        , m_y(y)
        , m_z(z)
    {
    }

    double x() const { return m_x; }
    double y() const { return m_y; }
    double z() const { return m_z; }

private:
    double m_x = 0.0;
    double m_y = 0.0;
    double m_z = 0.0;
};
