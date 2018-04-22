import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from math import sqrt

R = 16
C = 1e-6
L = 680e-6

D = 0.5

sys = signal.TransferFunction(
    [-L/(R*D**2), 1],
    [L*C/(D**2), L/(R*D**2), 1])

print("Poles", sys.poles)
print("Zeros", sys.zeros)

wb, mag, phase = sys.bode()

t, yout = sys.step()

wr, H = sys.freqresp()

plt.figure()
plt.plot(H.real, H.imag, "b")
plt.plot(H.real, -H.imag, "r")

# I would like to combine those, but the scale is way too different
plt.figure()
plt.plot(sys.poles.real, sys.poles.imag, "X")
plt.plot(sys.zeros.real, sys.zeros.imag, "o")

plt.figure()
plt.subplot(211)
plt.semilogx(wb, mag)    # Bode magnitude plot
plt.subplot(212)
plt.semilogx(wb, phase)  # Bode phase plot

plt.figure()
plt.plot(t, yout)

plt.show()
