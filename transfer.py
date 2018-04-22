import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from math import sqrt

R = 16
C = 1e-6
L = 680e-6

D = 0.5

def ctl2out(R, L, C, D):
    return signal.TransferFunction(
        [-L/(R*D**2), 1],
        [L*C/(D**2), L/(R*D**2), 1])

def predistort(R, L, C, D):
    return signal.TransferFunction(
        [1],
        [-L/(R*D**2), 1])


def bodeplots(R, L, C, num):
    plt.figure()
    ax1 = plt.subplot(211)
    ax2 = plt.subplot(212)
    for D in np.linspace(0.1, 0.9, num):
        sys = ctl2out(R, L, C, D)

        wb, mag, phase = sys.bode()

        ax1.semilogx(wb, mag, label="D=%.2f"%D)    # Bode magnitude plot
        ax2.semilogx(wb, phase, label="D=%.2f"%D)  # Bode phase plot

    ax1.legend()
    ax2.legend()

def step(R, L, C, num):
    plt.figure()
    for D in np.linspace(0.1, 0.9, num):
        sys = ctl2out(R, L, C, D)

        t, yout = sys.step()
        plt.plot(t, yout, label="D=%.2f"%D)

    plt.legend()


def poles(R, L, C, num):
    plt.figure()
    p1 = []
    p2 = []
    z = []
    for D in np.linspace(0.1, 0.9, num):
        sys = ctl2out(R, L, C, D)
        z.append(sys.zeros[0])
        p1.append(sys.poles[0])
        p2.append(sys.poles[1])

    plt.plot(np.real(p1), np.imag(p1), "-X")
    plt.plot(np.real(p2), np.imag(p2), "-X")
    plt.plot(np.real(z), np.imag(z), "-o")

if __name__ == "__main__":
    bodeplots(R, L, C, 5)
    step(R, L, C, 8)
    poles(R, L, C, 15)
    plt.show()

if False:

    wr, H = sys.freqresp()

    plt.figure()
    plt.plot(H.real, H.imag, "b")
    plt.plot(H.real, -H.imag, "r")

    # I would like to combine those, but the scale is way too different
    plt.figure()
    plt.plot(sys.poles.real, sys.poles.imag, "X")
    plt.plot(sys.zeros.real, sys.zeros.imag, "o")


    plt.figure()
    plt.plot(t, yout)

    plt.show()
