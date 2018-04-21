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

plt.figure()
plt.semilogx(wb, 20*np.log10(mag))    # Bode magnitude plot
plt.figure()
plt.semilogx(wb, phase)  # Bode phase plot

plt.figure()
plt.plot(t, yout)

plt.show()
