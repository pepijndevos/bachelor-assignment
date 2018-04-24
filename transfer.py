import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from math import sqrt, pi

R = 4
C = 0.332e-6
L = 21.3e-6

#actually D'
Dmin = 1/3
Dmax = 1

def ctl2out(R, L, C, D):
    w0 = D/sqrt(L*C)
    wz = D**2*R/L
    Q = D*R*sqrt(C/L)
    print(w0/2/pi, wz/2/pi, Q)
    return signal.TransferFunction(
        [-1/wz, 1],
        #[1],
        [1/w0**2, 1/(w0*Q), 1])

def predistort(R, L, C, D):
    return signal.TransferFunction(
        [1],
        [-L/(R*D**2), 1])


def bodeplots(R, L, C, num):
    plt.figure()
    ax1 = plt.subplot(211)
    ax1.grid(which='both')
    ax2 = plt.subplot(212)
    ax2.grid(which='both')
    for D in np.linspace(Dmin, Dmax, num):
        sys = ctl2out(R, L, C, D)

        wb, mag, phase = sys.bode()

        ax1.semilogx(wb/2/pi, mag, label="D=%.2f"%D)    # Bode magnitude plot
        ax2.semilogx(wb/2/pi, phase, label="D=%.2f"%D)  # Bode phase plot

    ax1.legend()
    ax2.legend()

def polebode(R, L, C, num):
    plt.figure()
    plt.grid(which='both')
    for D in np.linspace(Dmin, Dmax, num):
        sys = ctl2out(R, L, C, D)

        pz = signal.TransferFunction([1], [-1/sys.poles[0], 1])
        wb, mag, phase = pz.bode()
        plt.semilogx(wb/2/pi, mag, label="P0 D=%.2f"%D)    # Bode magnitude plot

        pz = signal.TransferFunction([1], [-1/sys.poles[1], 1])
        wb, mag, phase = pz.bode()
        plt.semilogx(wb/2/pi, mag, label="P1 D=%.2f"%D)    # Bode magnitude plot

        pz  = signal.TransferFunction([-1/sys.zeros[0], 1], [1])
        wb, mag, phase = pz.bode()
        plt.semilogx(wb/2/pi, mag, label="Z D=%.2f"%D)    # Bode magnitude plot

    plt.legend()

def step(R, L, C, num):
    plt.figure()
    plt.grid(which='both')
    for D in np.linspace(Dmin, Dmax, num):
        sys = ctl2out(R, L, C, D)

        t, yout = sys.step()
        plt.plot(t, yout, label="D=%.2f"%D)

    plt.legend()


def poles(R, L, C, num):
    plt.figure()
    plt.grid(which='both')
    p1 = []
    p2 = []
    z = []
    for D in np.linspace(Dmin, Dmax, num):
        sys = ctl2out(R, L, C, D)
        z.append(sys.zeros[0])
        p1.append(sys.poles[0])
        p2.append(sys.poles[1])

    plt.plot(np.real(p1)/2/pi, np.imag(p1)/2/pi, "-o")
    plt.plot(np.real(p2)/2/pi, np.imag(p2)/2/pi, "-o")
    plt.plot(np.real(z)/2/pi, np.imag(z)/2/pi, "-o")

if __name__ == "__main__":
    polebode(R, L, C, 2)
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
