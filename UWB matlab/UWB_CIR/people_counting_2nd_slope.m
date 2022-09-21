clc;clear;
%%
number_of_CIR = 100 ;
max_x = 5; % ch5 ê²½ìš°?˜ ?ˆ˜
max_y = 5; % ch9 ê²½ìš°?˜ ?ˆ˜
m1_total =[]
for i = 0 : 1 : max_x-1
 tempText = "dataset/" + i + "_ch5.csv"
 m1 = xlsread(tempText);
 m1_total = [m1_total m1] ;
end
for i = 0 : 1 : max_y-1
 tempText = "dataset/" + i + "_ch9.csv"
 m1 = xlsread(tempText);
 m1_total = [m1_total m1] ;
end

m2 = m1_total';
CIR = m2(:,1:end-1)
fp_ind = m2(:,end);

%%
CIR_fpindex=[];
CIR_fpindex_dot=[];
for c=1:1:number_of_CIR *(max_x+max_y);
    CIR_fpindex(c)=fp_ind(c*2-1);
    CIR_fpindex_dot(c)=rem(fp_ind(c*2-1),1); 
end
%%
number = 1
for c = 1 : 1 : number_of_CIR *(max_x+max_y)
    Mag = sqrt(CIR(2*c-1,:).^2 + CIR(2*c,:).^2);
    % fp_index(number,:) = fp_ind( 2*c-1,1);
    theta = atan2(CIR(2*c,:),CIR(2*c-1,:));
    
    Mag_all(number,:) = Mag;
    theta_b(number,:) = theta;
    theta_v(number,:) = theta * 180/3.14;
    number = number + 1;
end
%% upsampling
% original sample and upsample ratio
for c = 1:1:number_of_CIR *(max_x+max_y)
x = Mag_all(c,:)
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
%%
%% first path index?˜ ?†Œ?ˆ˜? ?„ ê¸°ì??œ¼ë¡? align?•˜ê¸?
people_count_upsampling_index=[];
for c=1:1:number_of_CIR *(max_x+max_y)
    move_square=CIR_fpindex_dot(c)*64;
    people_count_upsampling_index=[people_count_upsampling_index move_square];
end

for c=1:1:number_of_CIR *(max_x+max_y)
   move_index=64*2+3-ceil(people_count_upsampling_index(c));
%     move_index=ceil(people_count_upsampling_index(c))-64*2+3; %??ë¦?.
   people_count_upsampling_total(c,:)=circshift(people_count_upsampling(c,:),move_index); 
end
%% normalize ?•˜ê¸? 1 - ê°??¥ ?° ê°? ê¸°ì??œ¼ë¡? magnitude?˜ y ?Š¤ì¼??¼?„ ë§ì¶°ì£¼ê¸°
max_value_array = [];
for c = 1:1:number_of_CIR *(max_x+max_y)
     max_value_array = [max_value_array max(people_count_upsampling_total(c,:))];
end
max_value = max(max_value_array)
for c = 1:1:number_of_CIR *(max_x+max_y)
     max_value_line = max(people_count_upsampling_total(c,:));
     division_value = max_value/max_value_line;
     people_count_upsampling_total(c,:) = people_count_upsampling_total(c,:) * division_value;
end
people_count_upsampling_total = people_count_upsampling_total/2;


    %% downsampling
    people_count_CIR = [];
    for c = 1 : 1 : number_of_CIR * (max_x+max_y)
         people_count_CIR = [people_count_CIR ; downsample(people_count_upsampling_total(c,:),64)];
    end
%%
for xx = 0 : 1 : (max_x+max_y) -1
    people_count_CIR_ea = people_count_CIR(1+number_of_CIR*xx : number_of_CIR+ number_of_CIR*xx , :)
    people_Dmatrix = [];
    for c = 1: 1 : number_of_CIR-1  
        start_point = c+1;
        for a = start_point : 1 :  number_of_CIR
            Dmatrix =  people_count_CIR_ea(c,:) - people_count_CIR_ea(a,:); %? „ì²˜ë¦¬ ?›„
    %         Dmatrix =  people_count(c,:) - people_count(a,:); %? „ì²˜ë¦¬ ? „
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
    a=1;
    
    figure(5)
    if xx< 5
        subplot(2,1,1);
        plot(singularity,'LineWidth',2);
        hold on;
        title('ì±„ë„ 5(? „ì²˜ë¦¬ ?›„)','Fontsize',11);
        xlabel('index','Fontsize',11);
        ylabel('singular value','Fontsize',11);
        xticks([0:2:11]);
        ylim([0 14e4]);
        legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',11);
    end
    if xx >= 5
        subplot(2,1,2);
        plot(singularity,'LineWidth',2);
        hold on;
        title('ì±„ë„ 9(? „ì²˜ë¦¬ ?›„)','Fontsize',11);
        xlabel('index','Fontsize',11);
        ylabel('singular value','Fontsize',11);
        xticks([0:2:11]);
        ylim([0 14e4]);
        legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',11);
	    sgtitle('?‚¬?Œ ?ˆ˜?— ?”°ë¥? ?Š¹?´ê°? ë³??™”?–‘?ƒ','Fontsize',13);
    end
end

%% ±×·¡ÇÁ ±×¸®±â
for start_CIR_number = 501:100:901
    start = start_CIR_number;
    window_sliding = 50
    slope_1_total = [];
    slope_2_total = [];
    slope_3_total = [];
    center_of_gravity_total = [];
    singularity_total = [];
    area_under_curve_total = [];
    average_slope = 0;
    average_slope_total = [];
    for count = start:1:start+window_sliding
        people_count_CIR_ea = people_count_CIR(count : count+window_sliding-1 , :);
        people_Dmatrix = [];
        for c = 1: 1 : window_sliding-1  
            start_point = c+1;
            for a = start_point : 1 :  window_sliding
                Dmatrix =  people_count_CIR_ea(c,:) - people_count_CIR_ea(a,:); %? „ì²˜ë¦¬ ?›„
        %         Dmatrix =  people_count(c,:) - people_count(a,:); %? „ì²˜ë¦¬ ? „
                people_Dmatrix = [people_Dmatrix ; Dmatrix];
            end
        end
        %% SVD matrix
        [U,S,V] = svd(people_Dmatrix);
        pseudo_diagonal_matrix = S;
        singularity = [];
        for c = 1:1:64
            singularity = [singularity pseudo_diagonal_matrix(c,c)];
        end
        slope_1 = singularity(1)-singularity(2);
        slope_2 = singularity(2)-singularity(3);
        slope_3 = (singularity(4)-singularity(15))/12;
        x_point = 1:1:64;
        center_of_gravity = sum(singularity.*x_point)/sum(singularity);
        area_under_curve = sum(singularity);
        for a = 1: 1: window_sliding - 1
            average_slope = average_slope + (singularity(a) -singularity(a+1));
        end
        average_slope = average_slope/window_sliding;
        slope_1_total = [slope_1_total slope_1];
        slope_2_total = [slope_2_total slope_2];
        slope_3_total = [slope_3_total slope_3];
        center_of_gravity_total = [center_of_gravity_total center_of_gravity];
        area_under_curve_total = [area_under_curve_total area_under_curve];
        singularity_total= [singularity_total;singularity];
        average_slope_total = [average_slope_total average_slope];

    end
    figure(6)
    plot(area_under_curve_total,slope_3_total,'.');
    xlim([0 12e5]);
    ylim([300 4000]);
    title('Featuremap of the singularity value','Fontsize',15)
    legend('0 people','1 person','2 people','3 people','4 people','Fontsize',11);
    xlabel('Area under curve','Fontsize',13);
    ylabel('Slope of singularity Index4~15 ,'Fontsize',13);
    hold on;
    drawnow;
end
%%
% 1) singular value ê·¸ë˜?”„
% figure(1)
% plot(singularity(5:15),'LineWidth',2);
% hold on;
% title('singular values for different number of people','Fontsize',16);
% % title('?‚¬?Œ ?ˆ˜?— ?”°ë¥? ?Š¹?´ê°? ë³??™”?–‘?ƒ','Fontsize',16);
% xlabel('index','Fontsize',13);
% ylabel('singular value','Fontsize',13);
% xticks([0:2:11]);
% legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',13);
% 
% 2) original -> upsample -> normalizeê¹Œì? -> downsampleê¹Œì? (?›Œ?“œ1-a)
% subplot(4,1,1)
%  for c = 1:1:number_of_CIR
%      plot(people_count(c,:))
%      hold on;
%  end
% title('1. original','Fontsize',11);
% xlabel('index','Fontsize',10);
% ylabel('Magnitude','Fontsize',10);
% xlim([0 64]);
% ylim([0 9000]);
% 
% subplot(4,1,2)
%  for c = 1:1:number_of_CIR
%      plot(people_count_upsampling(c,:))
%      hold on;
%  end
% title('2. upsampling','Fontsize',11);
% xlabel('index','Fontsize',10);
% ylabel('Magnitude','Fontsize',10);
% xlim([0 4096]);
% ylim([0 9000]);
% 
% subplot(4,1,3)
%  for c = 1:1:number_of_CIR
%      plot(people_count_upsampling_total(c,:))
%      hold on;
%  end
% title('3. align & normalize','Fontsize',11);
% xlabel('index','Fontsize',10);
% ylabel('Magnitude','Fontsize',10);
% xlim([0 4096]);
% ylim([0 5000]);
% 
% subplot(4,1,4)
% for c = 1:1:number_of_CIR
%      plot(people_count_CIR(c,:))
%      hold on;
%  end
% title('4. downsample','Fontsize',11);
% xlabel('index','Fontsize',10);
% ylabel('Magnitude','Fontsize',10);
% xlim([0 64]);
% ylim([0 5000]);
% sgtitle('?°?´?„° ? „ì²˜ë¦¬?— ?”°ë¥? CIR ?–‘?ƒ','Fontsize',13);
% 
% 3) single CIR ê·¸ë˜?”„
% figure(3)
%  for c = 1:1:number_of_CIR
%      plot(people_count_upsampling_total(c,:))
%      hold on;
%  end
% title('CIR - 4ëª?','Fontsize',16);
% xlabel('index','Fontsize',13);
% ylabel('Magnitude','Fontsize',13);
% xlim([0 4096]); %downsample ? „ ê·¸ë˜?”„?¼ë©?
% xlim([0 64]) %downsample ?›„ ê·¸ë˜?”„?¼ë©?

%% ?›Œ?“œ 1-b
% a=2;
% 
% figure(4)
% if a==1
%     subplot(2,1,1);
%     plot(singularity(5:15),'LineWidth',2);
%     hold on;
%     title('? „ì²˜ë¦¬ ? „','Fontsize',11);
%     xlabel('index','Fontsize',11);
%     ylabel('singular value','Fontsize',11);
%     xticks([0:2:11]);
%     ylim([0 14e4]);
%     legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',11);
% end
% if a==2
%     subplot(2,1,2);
%     plot(singularity(5:15),'LineWidth',2);
%     hold on;
%     title('? „ì²˜ë¦¬ ?›„','Fontsize',11);
%     xlabel('index','Fontsize',11);
%     ylabel('singular value','Fontsize',11);
%     xticks([0:2:11]);
%     ylim([0 14e4]);
%     legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',11);
% 	sgtitle('?‚¬?Œ ?ˆ˜?— ?”°ë¥? ?Š¹?´ê°? ë³??™”?–‘?ƒ','Fontsize',13);
% end

%% ?›Œ?“œ 2-a

% a=2;
% 
% figure(5)
% if a==1
%     subplot(2,1,1);
%     plot(singularity(5:15),'LineWidth',2);
%     hold on;
%     title('ì±„ë„ 5(? „ì²˜ë¦¬ ?›„)','Fontsize',11);
%     xlabel('index','Fontsize',11);
%     ylabel('singular value','Fontsize',11);
%     xticks([0:2:11]);
%     ylim([0 14e4]);
%     legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',11);
% end
% if a==2
%     subplot(2,1,2);
%     plot(singularity(5:15),'LineWidth',2);
%     hold on;
%     title('ì±„ë„ 9(? „ì²˜ë¦¬ ?›„)','Fontsize',11);
%     xlabel('index','Fontsize',11);
%     ylabel('singular value','Fontsize',11);
%     xticks([0:2:11]);
%     ylim([0 14e4]);
%     legend('0ëª?','1ëª?','2ëª?','3ëª?','4ëª?','5ëª?','Fontsize',11);
% 	sgtitle('?‚¬?Œ ?ˆ˜?— ?”°ë¥? ?Š¹?´ê°? ë³??™”?–‘?ƒ','Fontsize',13);
% end
