clc;clear;
for n=1:10
    prompt_x = 'x의 좌표는 무엇입니까? ';
    x = input(prompt_x);
    prompt_y = 'y의 좌표는 무엇입니까? ';
    y = input(prompt_y);
    x_hole=rand(1,10);
    x_hole = x_hole + x-0.5;
    y_hole=rand(1,10);
    y_hole = y_hole + y-0.5;
    [row, col]=size(x_hole);
    error_distance= [];
    for n=1:col
       error_distance = [error_distance sqrt((x-x_hole(n))^2 + (y-y_hole(n))^2)]
    end
    hold on;
    avg = mean(error_distance);
    Std = std(error_distance);
    plot(x_hole,y_hole,'o');
    xlim([0 10]);
    ylim([0 10]);
    txt_1 = ['\leftarrow avg:',num2str(avg)];
    txt_2 = ['\leftarrow std:',num2str(Std)];
    text(x,y,txt_1,'FontSize',8);
    text(x,y-0.15,txt_2,'FontSize',8);
    drawnow;
end




