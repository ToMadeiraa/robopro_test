#pragma once

#include "Vector3.h"

class Matrix4
{
public:
    Matrix4();

    // матрица DH-преобразования
    static Matrix4 fromDh(double thetaRad, double d, double a, double alphaRad);
    Matrix4 operator*(const Matrix4 &other) const;
    // вектор переноса
    Vector3 translation() const;

private:
    double m_values[16];
};
