#pragma once

class DhLink
{
public:
    // создаёт звено с заданными параметрами
    DhLink(double a, double d, double alphaRad)
        : m_a(a)
        , m_d(d)
        , m_alphaRad(alphaRad)
    {
    }

    double a() const { return m_a; }
    double d() const { return m_d; }
    double alphaRad() const { return m_alphaRad; }

private:
    double m_a;         // смещение вдоль X, м
    double m_d;         // смещение вдоль Z, м
    double m_alphaRad;  // угол скрутки, рад.
};
