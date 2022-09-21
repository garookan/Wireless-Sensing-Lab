clc;clear;
delete(instrfindall)
s = serial('COM24','BaudRate',115200);
x_hole=[];
y_hole=[];
fopen(s);
New_distance_A = 0;
New_distance_B = 0;
New_distance_C = 0;
for n=1:1000
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
   axis([-1 3 -1 3]);
   plot(0,0,'-o');
   text(0,0,'\leftarrow Anchor-A');
   plot(0,1.8,'-o');
   text(0,1.8,'\leftarrow Anchor-B');
   plot(1.2,1.8,'-o');
   text(1.2,1.8,'\leftarrow Anchor-C');
   
   figure(2)
   plot(x_hole,y_hole,'-');
   axis([-1 3 -1 3]);
   plot(0,0,'-o');
   text(0,0,'\leftarrow Anchor-A');
   plot(0,1.8,'-o');
   text(0,1.8,'\leftarrow Anchor-B');
   plot(1.2,1.8,'-o');
   text(1.2,1.8,'\leftarrow Anchor-C');
   drawnow;
   end
  
   
end