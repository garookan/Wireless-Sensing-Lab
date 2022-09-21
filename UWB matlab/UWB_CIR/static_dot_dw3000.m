clc;clear;
x_dot_position = [];
y_dot_position = [];
real_dot= [0 0.8
           0 1.6
           0 2.4
           0 3.2
           1.2 3.2
           1.2 2.4
           1.2 1.6
           1.2 0.8
           2.4 0.8
           2.4 1.6
           2.4 2.4
           2.4 3.2];
for c=1:1:12
  filename = "CH9 ("+c+").txt";
  fid = fopen(filename);
  for i=1:1,buffer = fgetl(fid); end
  data = textscan(fid,'%s%s%f%s%s%s%f');
  x = data{3}
  y = data{7}
  x_dot_position = [x_dot_position x]
  y_dot_position = [y_dot_position y]
end
for c = 1:1:12
    error_distance = [];
    figure(1);
    hold on;
    grid on;
    plot(x_dot_position(:,c),y_dot_position(:,c),'o');
    title("DW3000-CH9");
    xlim([-2 5]);
    ylim([-2 5]);
    plot(0,0,'-o');
    text(0,0,'\leftarrow Anchor-A');
    plot(2.4,0,'-o');
    text(2.4,0,'\leftarrow Anchor-B');
    plot(0,4,'-o');
    text(0,4,'\leftarrow Anchor-C');
    % 좌표와 에러값 계산
    for a = 1: 1 :50
        error_distance = [error_distance sqrt((real_dot(c,1)-x_dot_position(a,c))^2 + (real_dot(c,2)-y_dot_position(a,c))^2)];
    end
    avg = mean(error_distance);
    Std = std(error_distance);
    txt_avg = ['\leftarrow avg:',num2str(avg)]
    txt_Std = ['     std:',num2str(Std)]
    text(real_dot(c,1),real_dot(c,2),txt_avg,'FontSize',8);
    text(real_dot(c,1),real_dot(c,2)-0.15,txt_Std,'FontSize',8);


end

%%
clc;clear;
x_dot_position = [];
y_dot_position = [];
real_dot= [1.2 2.4
           1.2 3.2
           0 3.2
           0 2.4
           0 1.6
           0 0.8
           2.4 3.2
           2.4 2.4
           2.4 1.6
           2.4 0.8
           1.2 0.8
           1.2 1.6];
for c=1:1:12
  filename = "CH5 ("+c+").txt";
  fid = fopen(filename);
  for i=1:1,buffer = fgetl(fid); end
  data = textscan(fid,'%s%s%f%s%s%s%f');
  x = data{3}
  y = data{7}
  x_dot_position = [x_dot_position x]
  y_dot_position = [y_dot_position y]
end
for c = 1:1:12
    error_distance = [];
    figure(2);
    hold on;
    grid on;
    %기본 좌표값 계산
    plot(x_dot_position(:,c),y_dot_position(:,c),'o')
    title("DW3000-CH9");
    xlim([-2 5]);
    ylim([-2 5]);
    plot(0,0,'-o');
    text(0,0,'\leftarrow Anchor-A');
    plot(2.4,0,'-o');
    text(2.4,0,'\leftarrow Anchor-B');
    plot(0,4,'-o');
    text(0,4,'\leftarrow Anchor-C');
    % 좌표와 에러값 계산
    for a = 1: 1 :50
        error_distance = [error_distance sqrt((real_dot(c,1)-x_dot_position(a,c))^2 + (real_dot(c,2)-y_dot_position(a,c))^2)];
    end
    avg = mean(error_distance);
    Std = std(error_distance);
    txt_avg = ['\leftarrow avg:',num2str(avg)]
    txt_Std = ['     std:',num2str(Std)]
    text(real_dot(c,1),real_dot(c,2),txt_avg,'FontSize',8);
    text(real_dot(c,1),real_dot(c,2)-0.15,txt_Std,'FontSize',8);

end

