%% 수직 데이터 받기  [1] => [1],[2]중 하나만 실행하기
clc;clear; 
CIR_total = [];
for i = -50 : 5 : 50
 filename = "\CIR_-50~50\" + i + "도_수직.xlsx";
 CIR = xlsread(filename,1,'A2:B65');
 CIR_total = [CIR_total CIR]
end
CIR_total = CIR_total.';

number_of_CIR = 21;
fprintf("excel to matlab => data download done \n");
%% 수평데이터 받기 [2]  => [1],[2]중 하나만 실행하기
clc;clear;
CIR_total = [];
for i = -50 : 5 : 50
 filename = "\CIR_-50~50\" + i + "도_수평.xlsx"
 CIR = xlsread(filename,1,'A2:B65');
 CIR_total = [CIR_total CIR]
end
CIR_total = CIR_total.';
number_of_CIR = 21
%% MAG 구하기
for c = 1 : 1 : number_of_CIR
Mag = sqrt(CIR_total(2*c-1,:).^2 + CIR_total(2*c,:).^2);
Mag_total(c,:) = Mag;
end

%% MAG_upsamling 하기
% original sample and upsample ratio
for c = 1:1:number_of_CIR
x = Mag_total(c,:);
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
Mag_total_upsampling(c,:) = x_upsample;
end
%%  color bar 조정
colorbar_customized = getPyPlot_cMap('inferno_r', 128);

%%
y = -50 : 5 :50;
x = 1/64:1/64:64;
figure(1)
subplot(2,1,1)
s=surf(x,y,Mag_total_upsampling);
s.EdgeColor = 'none';
colormap(colorbar_customized);
colorbar('eastoutside')
view(2)

subplot(2,1,2)
s=surf(x,y,Mag_total_upsampling);
s.EdgeColor = 'none';
colormap(colorbar_customized);
colorbar('eastoutside')

