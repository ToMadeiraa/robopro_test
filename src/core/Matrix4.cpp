#include "Matrix4.h"

#include <cmath>

Matrix4::Matrix4()
    : m_values{1.0, 0.0, 0.0, 0.0,
               0.0, 1.0, 0.0, 0.0,
               0.0, 0.0, 1.0, 0.0,
               0.0, 0.0, 0.0, 1.0}
{
}

Matrix4 Matrix4::fromDh(double thetaRad, double d, double a, double alphaRad)
{
    const double cosTheta = std::cos(thetaRad);
    const double sinTheta = std::sin(thetaRad);
    const double cosAlpha = std::cos(alphaRad);
    const double sinAlpha = std::sin(alphaRad);

    Matrix4 result;
    result.m_values[0] = cosTheta;
    result.m_values[1] = -sinTheta * cosAlpha;
    result.m_values[2] = sinTheta * sinAlpha;
    result.m_values[3] = a * cosTheta;

    result.m_values[4] = sinTheta;
    result.m_values[5] = cosTheta * cosAlpha;
    result.m_values[6] = -cosTheta * sinAlpha;
    result.m_values[7] = a * sinTheta;

    result.m_values[8] = 0.0;
    result.m_values[9] = sinAlpha;
    result.m_values[10] = cosAlpha;
    result.m_values[11] = d;

    result.m_values[12] = 0.0;
    result.m_values[13] = 0.0;
    result.m_values[14] = 0.0;
    result.m_values[15] = 1.0;

    return result;
}

Matrix4 Matrix4::operator*(const Matrix4 &other) const
{
    Matrix4 result;

    for (int row = 0; row < 4; ++row) {
        for (int column = 0; column < 4; ++column) {
            double value = 0.0;
            for (int k = 0; k < 4; ++k)
                value += m_values[row * 4 + k] * other.m_values[k * 4 + column];
            result.m_values[row * 4 + column] = value;
        }
    }

    return result;
}

Vector3 Matrix4::translation() const
{
    return Vector3(m_values[3], m_values[7], m_values[11]);
}
