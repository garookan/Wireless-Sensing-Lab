clc;clear;
filename = '\CIR_dw3000-dw3000(CH5).xlsx'
CIR_1s_total = xlsread(filename,1,'A2:CV65'); %CIR[64] 총 50개

power_1s = xlsread(filename,1,'C76:C125');
phase_1s = xlsread(filename,1,'D76:D125');
power_100ms = xlsread(filename,2,'C76:C125');
phase_100ms = xlsread(filename,2,'D76:D125');
power_10ms = xlsread(filename,3,'C76:C125');
phase_10ms = xlsread(filename,3,'D76:D125');
power_5ms = xlsread(filename,4,'C76:C125');
phase_5ms = xlsread(filename,4,'D76:D125');
power_1ms = xlsread(filename,5,'C76:C125');
phase_1ms = xlsread(filename,5,'D76:D125');
grid on;


%===============================%
%dw3000(송신)->dw3000(수신)(CH5)
figure(1)
subplot(2,5,1)
plot(power_1s)
axis([0 50 -80 -40])
title('Power[1second]')
ylabel('RSS[dBm]')
subplot(2,5,6)
plot(phase_1s)
axis([0 50 -180 180])
title('Phase[1second]')
ylabel('phase[deg]')

subplot(2,5,2)
plot(power_100ms)
axis([0 50 -80 -40])
title('Power[100ms]')
ylabel('RSS[dBm]')
subplot(2,5,7)
plot(phase_100ms)
axis([0 50 -180 180])
title('Phase[100ms]')
ylabel('phase[deg]')


subplot(2,5,3)
plot(power_10ms)
axis([0 50 -80 -40])
title('Power[10ms]')
ylabel('RSS[dBm]')
subplot(2,5,8)
plot(phase_10ms)
axis([0 50 -180 180])
title('Phase[10ms]')
ylabel('phase[deg]')


subplot(2,5,4)
plot(power_5ms)
axis([0 50 -80 -40])
title('Power[5ms]')
ylabel('RSS[dBm]')
subplot(2,5,9)
plot(phase_5ms)
axis([0 50 -180 180])
title('Phase[5ms]')
ylabel('phase[deg]')


subplot(2,5,5)
plot(power_1ms)
axis([0 50 -80 -40])
title('Power[1ms]')
ylabel('RSS[dBm]')
subplot(2,5,10)
plot(phase_1ms)
axis([0 50 -180 180])
title('Phase[1ms]')
ylabel('phase[deg]')

%===============================%

%%
clc;clear;
filename = 'CIR_dw1000-dw3000(CH5).xlsx'
CIR_1s_total = xlsread(filename,1,'A2:CV65'); %CIR[64] 총 50개

power_1s = xlsread(filename,1,'C76:C125');
phase_1s = xlsread(filename,1,'D76:D125');
power_100ms = xlsread(filename,2,'C76:C125');
phase_100ms = xlsread(filename,2,'D76:D125');
power_10ms = xlsread(filename,3,'C76:C125');
phase_10ms = xlsread(filename,3,'D76:D125');
power_5ms = xlsread(filename,4,'C76:C125');
phase_5ms = xlsread(filename,4,'D76:D125');
power_1ms = xlsread(filename,5,'C76:C125');
phase_1ms = xlsread(filename,5,'D76:D125');
grid on;
hold on;

%===============================%
%dw1000(송신)->dw3000(수신)(CH5)
figure(2)
subplot(2,5,1)
plot(power_1s)
axis([0 50 -80 -40])
title('Power[1second]')
ylabel('RSS[dBm]')
subplot(2,5,6)
plot(phase_1s)
axis([0 50 -180 180])
title('Phase[1second]')
ylabel('phase[deg]')

subplot(2,5,2)
plot(power_100ms)
axis([0 50 -80 -40])
title('Power[100ms]')
ylabel('RSS[dBm]')
subplot(2,5,7)
plot(phase_100ms)
axis([0 50 -180 180])
title('Phase[100ms]')
ylabel('phase[deg]')


subplot(2,5,3)
plot(power_10ms)
axis([0 50 -80 -40])
title('Power[10ms]')
ylabel('RSS[dBm]')
subplot(2,5,8)
plot(phase_10ms)
axis([0 50 -180 180])
title('Phase[10ms]')
ylabel('phase[deg]')


subplot(2,5,4)
plot(power_5ms)
axis([0 50 -80 -40])
title('Power[5ms]')
ylabel('RSS[dBm]')
subplot(2,5,9)
plot(phase_5ms)
axis([0 50 -180 180])
title('Phase[5ms]')
ylabel('phase[deg]')


subplot(2,5,5)
plot(power_1ms)
axis([0 50 -80 -40])
title('Power[1ms]')
ylabel('RSS[dBm]')
subplot(2,5,10)
plot(phase_1ms)
axis([0 50 -180 180])
title('Phase[1ms]')
ylabel('phase[deg]')
%===============================%
%%
clc;clear;
filename = 'CIR_dw3000-dw3000(CH9).xlsx';
CIR_1s_total = xlsread(filename,1,'A2:CV65'); %CIR[64] 총 50개

power_1s = xlsread(filename,1,'C76:C125');
phase_1s = xlsread(filename,1,'D76:D125');
power_100ms = xlsread(filename,2,'C76:C125');
phase_100ms = xlsread(filename,2,'D76:D125');
power_10ms = xlsread(filename,3,'C76:C125');
phase_10ms = xlsread(filename,3,'D76:D125');
power_5ms = xlsread(filename,4,'C76:C125');
phase_5ms = xlsread(filename,4,'D76:D125');
power_1ms = xlsread(filename,5,'C76:C125');
phase_1ms = xlsread(filename,5,'D76:D125');

%===============================%
%dw3000(송신)->dw3000(수신)(CH9)
figure(3)
subplot(2,5,1)
plot(power_1s)
axis([0 50 -80 -40])
title('Power[1second]')
ylabel('RSS[dBm]')
subplot(2,5,6)
plot(phase_1s)
axis([0 50 -180 180])
title('Phase[1second]')
ylabel('phase[deg]')

subplot(2,5,2)
plot(power_100ms)
axis([0 50 -80 -40])
title('Power[100ms]')
ylabel('RSS[dBm]')
subplot(2,5,7)
plot(phase_100ms)
axis([0 50 -180 180])
title('Phase[100ms]')
ylabel('phase[deg]')


subplot(2,5,3)
plot(power_10ms)
axis([0 50 -80 -40])
title('Power[10ms]')
ylabel('RSS[dBm]')
subplot(2,5,8)
plot(phase_10ms)
axis([0 50 -180 180])
title('Phase[10ms]')
ylabel('phase[deg]')


subplot(2,5,4)
plot(power_5ms)
axis([0 50 -80 -40])
title('Power[5ms]')
ylabel('RSS[dBm]')
subplot(2,5,9)
plot(phase_5ms)
axis([0 50 -180 180])
title('Phase[5ms]')
ylabel('phase[deg]')


subplot(2,5,5)
plot(power_1ms)
axis([0 50 -80 -40])
title('Power[1ms]')
ylabel('RSS[dBm]')
subplot(2,5,10)
plot(phase_1ms)
axis([0 50 -180 180])
title('Phase[1ms]')
ylabel('phase[deg]')
%===============================%
