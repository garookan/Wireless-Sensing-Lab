clc;clear;
x_hole_hole =[];
y_hole_hole =[];
for n=1:13
%실제 좌표값 받기
prompt_x = 'x의 좌표는 무엇입니까? ';
x_fact = input(prompt_x);
prompt_y = 'y의 좌표는 무엇입니까? ';
y_fact = input(prompt_y);
%DW1000으로부터 측정한 좌표값 구하기
delete(instrfindall)
s = serial('COM8','BaudRate',115200);
x_hole=[];
y_hole=[];
fopen(s);
New_distance_A = 0;
New_distance_B = 0;
New_distance_C = 0;
    for n=1:100
       a = fscanf(s)
       compare_A = 'Range1';
       compare_B = 'Range2';
       compare_C = 'Range3';
       A_checking = contains(a,compare_A);
       B_checking = contains(a,compare_B);
       C_checking = contains(a,compare_C);
       if A_checking == 1
           New_distance_A = str2double(extractAfter(a,compare_A));
       elseif B_checking == 1
           New_distance_B = str2double(extractAfter(a,compare_B));
       elseif C_checking == 1
           New_distance_C = str2double(extractAfter(a,compare_C));
       end

       hold on
       grid on
       if (New_distance_A > 0) && (New_distance_B > 0) && (New_distance_C > 0) 
           [x,y] = distance(New_distance_A,New_distance_B,New_distance_C);
           x_hole = [x_hole x];
           y_hole = [y_hole y];
           % 그래프 그리기 시작!
           figure(1)
           plot(x,y,'d-');
           xlim([-2 5]);
           ylim([-2 5]);
           plot(0,0,'-o');
           text(0,0,'\leftarrow Anchor-A');
           plot(2.4,0,'-o');
           text(2.4,0,'\leftarrow Anchor-B');
           plot(0,4,'-o');
           text(0,4,'\leftarrow Anchor-C');

           figure(2)
           plot(x_hole,y_hole,'-');
           xlim([-2 5]);
           ylim([-2 5]);
           plot(0,0,'-o');
           text(0,0,'\leftarrow Anchor-A');
           plot(2.4,0,'-o');
           text(2.4,0,'\leftarrow Anchor-B');
           plot(0,4,'-o');
           text(0,4,'\leftarrow Anchor-C');
           drawnow;
       end


    end
[row, col]=size(x_hole);
error_distance= [];
for n=1:col
   error_distance = [error_distance sqrt((x_fact-x_hole(n))^2 + (y_fact-y_hole(n))^2)];
end
%평균값과 표준편차 좌표에 표현하기!
avg = mean(error_distance);
Std = std(error_distance);
txt_avg = ['\leftarrow avg:',num2str(avg)]
txt_Std = ['     std:',num2str(Std)]
text(x_fact,y_fact,txt_avg,'FontSize',8);
text(x_fact,y_fact-0.15,txt_Std,'FontSize',8);
%figure(3)
avg_x_dot = mean(x_hole);
avg_y_dot = mean(y_hole);
figure(3)
xlim([-2 5]);
ylim([-2 5]);
plot(avg_x_dot,avg_y_dot,'o')
plot(x_fact,y_fact,'d')
plot(0,0,'-o');
text(0,0,'\leftarrow Anchor-A');
plot(2.4,0,'-o');
text(2.4,0,'\leftarrow Anchor-B');
plot(0,4,'-o');
text(0,4,'\leftarrow Anchor-C');
text(avg_x_dot,avg_y_dot,num2str(avg_x_dot),'FontSize',8);
text(avg_x_dot,avg_y_dot-0.15,num2str(avg_y_dot),'FontSize',8);
drawnow;
%전체 좌표값 저장하기!
x_hole_hole =[x_hole_hole x_hole];
y_hole_hole =[y_hole_hole y_hole];
end


   



