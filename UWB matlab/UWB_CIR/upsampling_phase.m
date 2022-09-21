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
%% phase 계산
for c = 1:1:number_of_CIR
 CIR_phase = atan2(CIR_total(c*2,:),CIR_total(c*2-1,:))*180/pi;
 CIR_phase_total(c,:) = CIR_phase;
end
%% upsampling 하기   => x 축
for c = 1:1:number_of_CIR
x = CIR_phase_total(c,:);
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
CIR_phase_total_upsampling(c,:) = x_upsample;
end
%% normalization 하기!
for c = 1 : 1 : number_of_CIR
   empty_array = [];
   normalization = CIR_phase_total_upsampling(c,3*64); %FP_index부근을 0으로 normalization
   for a = 1:1:4096
        check = CIR_phase_total_upsampling(c,a)-normalization;
       if (check < -180)
           check = check + 360;
       elseif (check > 180)
           check = check - 360;
       end
       empty_array = [empty_array check];
   end
   CIR_phase_total_upsampling_normalization(c,:) = empty_array; 
end
%%  color bar 조정

colorbar_customized = getPyPlot_cMap('pink', 128);
colorbar_customized_flipud = flipud(colorbar_customized);
colorbar_a = [colorbar_customized,
            colorbar_customized_flipud];
%%
y = -50 : 5 :50;
x = 1/64:1/64:64;
figure(1)
subplot(2,1,1)
s=surf(x,y,CIR_phase_total_upsampling_normalization);
s.EdgeColor = 'none';
colormap(colorbar_a);
colorbar('eastoutside');
view(2)

subplot(2,1,2)
s=surf(x,y,CIR_phase_total_upsampling_normalization);
s.EdgeColor = 'none';
colormap(colorbar_a);
colorbar('eastoutside');




