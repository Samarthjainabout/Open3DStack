function recurrentHybridInput = fetft_recurrent_hybrid_dataset(tStop, dt)
%FETFT_RECURRENT_HYBRID_DATASET Build recurrent hybrid write-hold-read data.
%
% Output matrix columns:
%   time, phase, writeCommand, vEff17, vEff18,
%   pStart17, pStart18, pTarget17, pTarget18,
%   p17Preisach, p18Preisach, p17, p18,
%   dPProgrammed, retentionFactor, dP,
%   loopGain, polarizationGain, dVQ, senseMargin, refreshNeeded
%
% The key interaction is recurrent:
%   relaxed P at the end of one hold/read interval becomes the starting
%   Preisach state for the next write.

if nargin < 1
    tStop = 80e-6;
end

if nargin < 2
    dt = 5e-8;
end

params = default_params();
time = (0:dt:tStop).';
values = zeros(numel(time), 20);

p17State = 0.0;
p18State = 0.0;
row = 1;

segments = [ ...
    1,  1, 0e-6,  2e-6; ...
    2,  0, 2e-6, 22e-6; ...
    3,  0, 22e-6, 24e-6; ...
    1, -1, 24e-6, 26e-6; ...
    2,  0, 26e-6, 46e-6; ...
    3,  0, 46e-6, 48e-6; ...
    1,  1, 48e-6, 50e-6; ...
    2,  0, 50e-6, 70e-6; ...
    3,  0, 70e-6, 72e-6; ...
    2,  0, 72e-6, 80e-6];

for segIdx = 1:size(segments, 1)
    phase = segments(segIdx, 1);
    command = segments(segIdx, 2);
    t0 = segments(segIdx, 3);
    t1 = segments(segIdx, 4);

    if row > numel(time)
        break;
    end

    pStart17 = p17State;
    pStart18 = p18State;
    dPStart = pStart17 - pStart18;
    commonP = 0.5 * (pStart17 + pStart18);

    while row <= numel(time) && time(row) >= t0 - 0.5 * dt && time(row) < t1 - 0.5 * dt
        tLocal = time(row) - t0;

        if phase == 1
            [sample, p17State, p18State] = write_sample(time(row), tLocal, command, pStart17, pStart18, params);
        else
            isRead = phase == 3;
            [sample, p17State, p18State] = retention_sample(time(row), phase, command, tLocal, ...
                pStart17, pStart18, dPStart, commonP, isRead, params);
        end

        values(row, :) = sample;
        row = row + 1;
    end
end

while row <= numel(time)
    values(row, :) = retention_sample(time(row), 2, 0, time(row) - segments(end, 3), ...
        p17State, p18State, p17State - p18State, 0.5 * (p17State + p18State), false, params);
    row = row + 1;
end

recurrentHybridInput = [time, values];
end

function params = default_params()
params.vWrite = 2.4;
params.tauVeff = 0.28e-6;
params.pSat = 1.0;
params.alphaPreisach = 1.55;
params.vCoercive = 0.85;
params.minorScale = 0.78;

params.tauNls = 11e-6;
params.betaRetention = 0.62;
params.trapAccel = 0.18;
params.tauTrap = 25e-6;

params.aWrite = 0.25;
params.aHold = 0.35;
params.aRead = 0.88;
params.bWrite = 0.06;
params.bHold = 0.04;
params.bRead = 0.06;
params.vMin = 0.12;
end

function [sample, p17, p18] = write_sample(t, tLocal, command, pStart17, pStart18, params)
vProg17 = command * params.vWrite;
vProg18 = -command * params.vWrite;
vEff17 = delayed_voltage(vProg17, tLocal, params.tauVeff);
vEff18 = delayed_voltage(vProg18, tLocal, params.tauVeff);

pTarget17 = preisach_target(vEff17, params);
pTarget18 = preisach_target(vEff18, params);
p17 = minor_loop_update(pStart17, pTarget17, params);
p18 = minor_loop_update(pStart18, pTarget18, params);

dPProgrammed = p17 - p18;
retentionFactor = 1.0;
dP = dPProgrammed;
a = params.aWrite;
b = params.bWrite;
[polarizationGain, dVQ, senseMargin, refreshNeeded] = readout(dP, a, b, params.vMin);

sample = [1.0, command, vEff17, vEff18, ...
    pStart17, pStart18, pTarget17, pTarget18, ...
    p17, p18, p17, p18, ...
    dPProgrammed, retentionFactor, dP, ...
    a, polarizationGain, dVQ, senseMargin, refreshNeeded];
end

function [sample, p17, p18] = retention_sample(~, phase, command, tLocal, pStart17, pStart18, dPStart, commonP, isRead, params)
vEff17 = 0.0;
vEff18 = 0.0;
pTarget17 = pStart17;
pTarget18 = pStart18;
p17Preisach = pStart17;
p18Preisach = pStart18;
dPProgrammed = dPStart;
retentionFactor = retention_factor(tLocal, params);
dP = dPProgrammed * retentionFactor;
p17 = commonP + 0.5 * dP;
p18 = commonP - 0.5 * dP;

if isRead
    a = params.aRead;
    b = params.bRead;
else
    a = params.aHold;
    b = params.bHold;
end

[polarizationGain, dVQ, senseMargin, refreshNeeded] = readout(dP, a, b, params.vMin);

sample = [phase, command, vEff17, vEff18, ...
    pStart17, pStart18, pTarget17, pTarget18, ...
    p17Preisach, p18Preisach, p17, p18, ...
    dPProgrammed, retentionFactor, dP, ...
    a, polarizationGain, dVQ, senseMargin, refreshNeeded];
end

function value = delayed_voltage(vIn, tLocal, tauVeff)
if tLocal <= 0
    value = 0.0;
else
    value = vIn * (1.0 - exp(-tLocal / tauVeff));
end
end

function p = preisach_target(vEff, params)
if vEff >= 0
    pRaw = params.pSat * tanh(params.alphaPreisach * (vEff - params.vCoercive));
    p0 = params.pSat * tanh(params.alphaPreisach * (0.0 - params.vCoercive));
    p = params.minorScale * (pRaw - p0) / (params.pSat - p0);
else
    pRaw = params.pSat * tanh(params.alphaPreisach * (vEff + params.vCoercive));
    p0 = params.pSat * tanh(params.alphaPreisach * (0.0 + params.vCoercive));
    p = params.minorScale * (pRaw - p0) / (params.pSat + p0);
end
end

function p = minor_loop_update(pStart, pTarget, params)
% Reduced minor-loop update: the FE state follows a branch from the current
% relaxed state toward the Preisach target. Time dependence enters only
% through the RC-delayed Veff used to compute pTarget.
drive = min(abs(pTarget) / params.minorScale, 1.0);
p = pStart + drive * (pTarget - pStart);
end

function factor = retention_factor(tLocal, params)
if tLocal <= 0
    factor = 1.0;
    return;
end

trapMultiplier = 1.0 + params.trapAccel * (1.0 - exp(-tLocal / params.tauTrap));
factor = exp(-trapMultiplier * (tLocal / params.tauNls) ^ params.betaRetention);
end

function [polarizationGain, dVQ, senseMargin, refreshNeeded] = readout(dP, a, b, vMin)
if a >= 1.0
    a = 0.999999;
end

polarizationGain = b / (1.0 - a);
dVQ = polarizationGain * dP;
senseMargin = abs(dVQ) - vMin;
refreshNeeded = double(senseMargin < 0.0);
end
