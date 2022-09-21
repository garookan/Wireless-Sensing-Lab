clc;clear;
filename = '\CIR_-50~50\0도_수직.xlsx'
CIR = xlsread(filename,1,'A2:ALL65');
CIR_Index_dot = xlsread(filename,1,'A69:ALL69');
%%
number_of_CIR = 498 % 몇개의 CIR을 받아올 것인가.
%%

for a = 0 : 1 :63 % 소수점 64번째를 정렬i
    number = 0;
    Mag_dot_ea = [] ; %초기화
    Mag_mean_index = [] ; %초기화
    for c = 1 : 1 : number_of_CIR %1~499개의 CIR을 하나하나 파악
    Mag = sqrt(CIR(:,2*c-1).^2 + CIR(:,2*c).^2); %mag 계산
    Mag = Mag.'; %전치
    dot_index = CIR_Index_dot(2*c); % CIR의 소수점 자리 파악
        if (dot_index == a)
            Mag_dot_ea = [Mag_dot_ea; Mag];
            number = number +1;
        end
    
    end
    if(number == 0)
        Mag_mean_index = zeros(1,64);
    else
        for d = 1:1:64
            Mag_mean_index = [Mag_mean_index mean(Mag_dot_ea(:,d))]; % 같은 소수점들의 CIR을 평균값 계산
        end
    end
    Mag_mean_index_total(a+1,:) = Mag_mean_index;
end
%% normalize
Mag_mean_index_total_normalize = normalize(Mag_mean_index_total,2);
%% upsampling
Mag_end = zeros(1,4096);
for c = 1:1:64
     Mag_end = Mag_end + upsample(Mag_mean_index_total_normalize(c,:),64,64-c);
end
%% 전체 데이터와 소수점 CIR data plot
for c = 1:1:64
hold on;
a = 1+64-c : 64 : 64*64;
title_name = "index is "+ c + ". index 64 is last."; 
title(title_name);
plot(Mag_end,'.') % upsampling 한 CIR 데이터
plot(a,Mag_mean_index_total_normalize(c,:),'o','MarkerSize',8,'MarkerEdgeColor','blue','MarkerFaceColor','blue'); % 소수점 별로 CIR 표현
xticklabels({'0','7.825','15.65','23.475','31.3','39.125','46.95','54.775','62.6'});
xlabel("Dealy τ(ns)")
ylabel("Amplitude|h(τ)|")
legend('Accumulated CIRs', 'Single CIR')
hold off;
pause; % 키보드를 누를때 마다 하나씩 표현
clf; % plot clear
end
