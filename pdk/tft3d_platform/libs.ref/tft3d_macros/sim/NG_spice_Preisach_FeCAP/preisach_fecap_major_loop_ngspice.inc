* Native ngspice ferroelectric capacitor helper derived from the model blocks in:
* K. Ni, M. Jerry, J. A. Smith, and S. Datta,
* "A Circuit Compatible Accurate Compact Model for Ferroelectric-FETs", VLSI 2018.
*
* This include covers the FE saturation loop and switching-delay unit:
*   QFE = Qs*tanh(a*(Veff - branch*Vc)) + epsFE*VFE/tFE
*   dVeff/dt = (VFE - Veff) / tau(VFE)
*
* It does not implement the full turning-point minor-loop history or the
* self-consistent BSIM4 QMOS=QFE FeFET solver from the paper.
*
* Pin order:
*   p n branch qdens veff
*
* branch is a control voltage: +1 for the rising/program branch, -1 for the
* falling/erase branch. qdens reports QFE density in C/m^2 as a voltage.

.subckt preisach_fecap_major_loop_ngspice p n branch qdens veff
+ tfe=10n epsfe_r=20 qs=0.32 vc=1.05 slope=1.6 area=1e-12
+ tau_inf=1n v0=0.55 tau_m=2 vfloor=50m cdelay=1p

.param eps0=8.854187817e-12

* Nonlinear RC delay from Fig. 4: dVeff/dt = (VFE - Veff)/tau.
* abs(VFE) is floored so the expression remains finite near zero bias.
Bdelay veff 0 I={cdelay/(tau_inf*exp(pow(v0/max(abs(V(p,n)),vfloor),tau_m)))*(V(veff)-V(p,n))}
Cdelay veff 0 {cdelay} ic=0
Rveff veff 0 1e15

* Static major-loop branch from the paper's tanh Preisach saturation model.
Bqdens qdens 0 V={qs*tanh(slope*(V(veff)-((V(branch)>=0) ? 1 : -1)*vc)) + epsfe_r*eps0*V(p,n)/tfe}

* Current contribution for use in transient circuits.
Bfe p n I={area*ddt(V(qdens))}

.ends preisach_fecap_major_loop_ngspice

* Small-signal AC linearization of one selected FE branch around vbias.
* The polarization contribution is modeled as a Debye branch:
*   Ypol(s) = s*Cpol / (1 + s*tau)
* where Cpol = area*d(Qs*tanh(...))/dVeff at vbias.
* This subckt is intended for .ac only; use the nonlinear subckt above for
* large-signal transient major-loop checks.
.subckt preisach_fecap_branch_ac_ngspice p n
+ tfe=10n epsfe_r=20 qs=0.32 vc=1.05 slope=1.6 area=1e-12
+ tau_inf=1n v0=0.55 tau_m=2 vfloor=50m vbias=1 branch=1

.param eps0=8.854187817e-12
.param x0='slope*(vbias-branch*vc)'
.param cdiel='area*epsfe_r*eps0/tfe'
.param cpol='area*qs*slope/(cosh(x0)*cosh(x0))'
.param tau_fe='tau_inf*exp(pow(v0/max(abs(vbias),vfloor),tau_m))'
.param rpol='tau_fe/cpol'

Cdiel p n {cdiel}
Rpol p qpol {rpol}
Cpol qpol n {cpol}
Rdc p n 1e15

.ends preisach_fecap_branch_ac_ngspice
