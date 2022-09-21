clc;clear;
filename = '\people\0801_05_500ms.csv'
CIR = xlsread(filename,1,'A2:ALL65');
%%
number_of_CIR = 100 % 몇개의 CIR을 받아올 것인가.
%%
number = 1;
for c = 1 : 1 : number_of_CIR
Mag = sqrt(CIR(:,2*c-1).^2 + CIR(:,2*c).^2);
z(:,number) = Mag';
number = number + 1;
end
z = z.';
%% avg
mag_mean = []
mag_std = []
for c = 1 : 1 : 64
    mag_mean = [mag_mean mean(z(:,c))]
    mag_std  = [mag_std std(z(:,c))]
end
%% average, standard deviation 데이터 정리
y = mag_mean;
x = 1:1:64;
std_dev = mag_std;
curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

%% 그래프 그리기
s = fill(x2, inBetween, [0.7 0.8 1]);
s.EdgeColor = 'none';
hold on;
plot(x, y, 'b');
title('CH9 - people : 5','Fontsize',11);
xlabel('index','Fontsize',11);
ylabel('singular value','Fontsize',11);
ylim([-200 7000]);
xlim([0 64]);
xlabel("CIR Path Index")
ylabel("CIR Amplitude")
legend('Standard deviation', 'average','Fontsize',11)
hold off;

