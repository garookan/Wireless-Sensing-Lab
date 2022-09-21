%% ���� ������ �ޱ�  [1] => [1],[2]�� �ϳ��� �����ϱ�
clc;clear; 
CIR_total = [];
for i = -50 : 5 : 50
 filename = "\CIR_-50~50\" + i + "��_����.xlsx";
 CIR = xlsread(filename,1,'A2:B65');
 CIR_total = [CIR_total CIR]
end
CIR_total = CIR_total.';

number_of_CIR = 21;
fprintf("excel to matlab => data download done \n");
%% �������� �ޱ� [2]  => [1],[2]�� �ϳ��� �����ϱ�
clc;clear;
CIR_total = [];
for i = -50 : 5 : 50
 filename = "\CIR_-50~50\" + i + "��_����.xlsx"
 CIR = xlsread(filename,1,'A2:B65');
 CIR_total = [CIR_total CIR]
end
CIR_total = CIR_total.';
number_of_CIR = 21
%% phase ���
for c = 1:1:number_of_CIR
 CIR_phase = atan2(CIR_total(c*2,:),CIR_total(c*2-1,:))*180/pi;
 CIR_phase_total(c,:) = CIR_phase;
end
%% upsampling �ϱ�   => x ��
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
%% normalization �ϱ�!
for c = 1 : 1 : number_of_CIR
   empty_array = [];
   normalization = CIR_phase_total_upsampling(c,3*64); %FP_index�α��� 0���� normalization
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
%%  color bar ����

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




