clc;clear;
filename = '\CIR_-50~50\0��_����.xlsx'
CIR = xlsread(filename,1,'A2:ALL65');
CIR_Index_dot = xlsread(filename,1,'A69:ALL69');
%%
number_of_CIR = 498 % ��� CIR�� �޾ƿ� ���ΰ�.
%%

for a = 0 : 1 :63 % �Ҽ��� 64��°�� ����i
    number = 0;
    Mag_dot_ea = [] ; %�ʱ�ȭ
    Mag_mean_index = [] ; %�ʱ�ȭ
    for c = 1 : 1 : number_of_CIR %1~499���� CIR�� �ϳ��ϳ� �ľ�
    Mag = sqrt(CIR(:,2*c-1).^2 + CIR(:,2*c).^2); %mag ���
    Mag = Mag.'; %��ġ
    dot_index = CIR_Index_dot(2*c); % CIR�� �Ҽ��� �ڸ� �ľ�
        if (dot_index == a)
            Mag_dot_ea = [Mag_dot_ea; Mag];
            number = number +1;
        end
    
    end
    if(number == 0)
        Mag_mean_index = zeros(1,64);
    else
        for d = 1:1:64
            Mag_mean_index = [Mag_mean_index mean(Mag_dot_ea(:,d))]; % ���� �Ҽ������� CIR�� ��հ� ���
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
%% ��ü �����Ϳ� �Ҽ��� CIR data plot
for c = 1:1:64
hold on;
a = 1+64-c : 64 : 64*64;
title_name = "index is "+ c + ". index 64 is last."; 
title(title_name);
plot(Mag_end,'.') % upsampling �� CIR ������
plot(a,Mag_mean_index_total_normalize(c,:),'o','MarkerSize',8,'MarkerEdgeColor','blue','MarkerFaceColor','blue'); % �Ҽ��� ���� CIR ǥ��
xticklabels({'0','7.825','15.65','23.475','31.3','39.125','46.95','54.775','62.6'});
xlabel("Dealy ��(ns)")
ylabel("Amplitude|h(��)|")
legend('Accumulated CIRs', 'Single CIR')
hold off;
pause; % Ű���带 ������ ���� �ϳ��� ǥ��
clf; % plot clear
end
