clc;clear;
filename = '\CIR_-50~50\-45도_수직.xlsx'
CIR = xlsread(filename,1,'A2:ALL65');
%%
number_of_CIR = 200 % 몇개의 CIR을 받아올 것인가.
%%
number = 1;
for c = 1 : 1 : number_of_CIR
Mag = sqrt(CIR(:,2*c-1).^2 + CIR(:,2*c).^2);
z(:,number) = Mag';
number = number + 1;
end
z = z.';

%%
% original sample and upsample ratio
for c = 1:1:number_of_CIR
x = z(c,:)
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
z_value(c,:) = x_upsample;
end
%% 보드에 의한 FP_index 조정하기
z_max_each_value_index = [];
for c = 1 : 1 : number_of_CIR
[M,I] = max(z_value(c,:));
z_max_each_value_index = [z_max_each_value_index I];
end
z_min = min(z_max_each_value_index);

for c = 1:1:number_of_CIR
    move_index = z_min - z_max_each_value_index(c);
    z_value(c,:) = circshift(z_value(c,:),move_index);
end

%% normalize 하기
z_value_normal = normalize(z_value,2);
%% color bar 조정
colorbar_customized = getPyPlot_cMap('inferno_r', 128);
%%
subplot(2,1,1)
s=surf(z_value);
s.EdgeColor = 'none';
colormap(colorbar_customized);
colorbar('eastoutside');
view(2)
subplot(2,1,2)
s=surf(z_value_normal);
s.EdgeColor = 'none';
colormap(colorbar_customized);
colorbar('eastoutside');
view(2)