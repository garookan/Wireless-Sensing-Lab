clc;clear;
filename = '\people\0801_01_500ms.csv';
CIR = xlsread(filename,1,'A2:ALL65');
FPindex=xlsread(filename,1,'A67:ALL66');
%%
number_of_CIR = 100; % ��� CIR�� �޾ƿ� ���ΰ�.
%% first path index - �Ǽ�, �Ҽ���
CIR_fpindex=[];
CIR_fpindex_dot=[];
for c=1:1:number_of_CIR
    CIR_fpindex(c)=FPindex(c*2-1);
    CIR_fpindex_dot(c)=rem(FPindex(c*2-1),1); 
end
%%
number = 1;
for c = 1 : 1 : number_of_CIR
Mag = sqrt(CIR(:,2*c-1).^2 + CIR(:,2*c).^2);
z(:,number) = Mag';
number = number + 1;
end
people_count = z.';
%% upsampling
% original sample and upsample ratio
for c = 1:1:number_of_CIR
x = people_count(c,:)
r = 64;

% compute zero pad length and nonzero elements index
padlen = length(x)*(r-1);
sample_len_half = ceil((length(x)+1)/2);

% fft original sample and frequency shift
y = fft(x);
y_pad = [y(1:sample_len_half) zeros(1, padlen) y(sample_len_half+1:end)];

if  ~mod(length(x), 2); % even number
    y_pad(sample_len_half) = y_pad(sample_len_half)/2; y_pad(sample_len_half+padlen) = y_pad(sample_len_half);
end

% ifft shifted result and scaling with ratio
x_upsample = real(ifft(y_pad))*r; 
people_count_upsampling(c,:) = x_upsample;
end
%% first path index�� �Ҽ����� �������� align�ϱ�
people_count_upsampling_index=[];
for c=1:1:number_of_CIR
    move_square=CIR_fpindex_dot(c)*64;
    people_count_upsampling_index=[people_count_upsampling_index move_square];
end

for c=1:1:number_of_CIR
   move_index=64*2+3-ceil(people_count_upsampling_index(c));
%     move_index=ceil(people_count_upsampling_index(c))-64*2+3; %Ʋ��.
   people_count_upsampling_total(c,:)=circshift(people_count_upsampling(c,:),move_index); 
end
%% normalize �ϱ� 1 - ���� ū �� �������� magnitude�� y �������� �����ֱ�
max_value_array = [];
for c = 1:1:number_of_CIR
     max_value_array = [max_value_array max(people_count_upsampling_total(c,:))];
end
max_value = max(max_value_array)
for c = 1:1:number_of_CIR
     max_value_line = max(people_count_upsampling_total(c,:));
     division_value = max_value/max_value_line;
     people_count_upsampling_total(c,:) = people_count_upsampling_total(c,:) * division_value;
end
people_count_upsampling_total = people_count_upsampling_total/2;
%% downsampling
people_count_CIR = [];
for c = 1:1:number_of_CIR
     people_count_CIR = [people_count_CIR ; downsample(people_count_upsampling_total(c,:),64)];
end

%% Dmatrix ���ϱ�
people_Dmatrix = [];
for c = 1: 1 : number_of_CIR-1
    start_point = c+1;
    for a = start_point : 1 : number_of_CIR
        Dmatrix =  people_count_CIR(c,:) - people_count_CIR(a,:);
        people_Dmatrix = [people_Dmatrix ; Dmatrix];
    end
end
%% SVD matrix
[U,S,V] = svd(people_Dmatrix);
pseudo_diagonal_matrix = S;
singularity = [];
for c = 1:1:64
    singularity = [singularity pseudo_diagonal_matrix(c,c)]
end
%%
%1) singular value �׷���
figure(1)
plot(singularity(5:15),'LineWidth',2);
hold on;
title('singular values for different number of people','Fontsize',16);
xlabel('index','Fontsize',13);
ylabel('singular value','Fontsize',13);
xticks([0:2:11]);
legend('0��','1��','2��','3��','4��','5��','Fontsize',13);

%%
%2) upsample -> normalize���� -> downsample����
figure(2)
subplot(3,1,1)
 for c = 1:1:number_of_CIR
     plot(people_count_upsampling(c,:))
     hold on;
 end
title('<5��> upsample ���','Fontsize',16);
subplot(3,1,2)
 for c = 1:1:number_of_CIR
     plot(people_count_upsampling_total(c,:))
     hold on;
 end
title('RE align','Fontsize',16);
xlabel('index','Fontsize',13);
ylabel('Magnitude','Fontsize',13);
subplot(3,1,3)
for c = 1:1:number_of_CIR
     plot(people_count_CIR(c,:))
     hold on;
 end
title('����','Fontsize',16);

% 3) single CIR �׷���
figure(3)
 for c = 1:1:number_of_CIR
     plot(people_count_upsampling_total(c,:))
     hold on;
 end
title('CIR - 0��','Fontsize',16);
xlabel('index','Fontsize',13);
ylabel('Magnitude','Fontsize',13);
xlim([0 4096]);

%% ��� ���� ���� CIR ���
while(1)
    figure(4)
    for c = 1:5:100
        a = randi([1 100],1)
        hold on;
        plot(people_count(a,:),'b','LineWidth',1)
    end
    pause;
    clf;
end
    
    
    
    
    
