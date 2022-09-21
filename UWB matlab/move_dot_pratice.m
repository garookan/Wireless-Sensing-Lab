clc;clear;
x_hole=[];
y_hole=[];
New_distance_A = 0;
New_distance_B = 0;
New_distance_C = 0;
for n=1:6

%      New_distance_A = random('Normal',0.65,0.03); %A일때
%      New_distance_B = random('Normal',1.47,0.03);
%      New_distance_C = random('Normal',1.57,0.03);

      New_distance_A = random('Normal',0.86,0.03);  %B일때s
      New_distance_B = random('Normal',1.65,0.03);
      New_distance_C = random('Normal',1.47,0.03);
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
   
   drawnow;
   end
   pause(1);
   
   
end
   figure(2)
   hold on;
   grid on;
   plot(mean(x_hole),mean(y_hole),'o');
   axis([-1 3 -1 3]);
   plot(0,0,'-o');
   text(0,0,'\leftarrow Anchor-A');
   plot(0,1.8,'-o');
   text(0,1.8,'\leftarrow Anchor-B');
   plot(1.2,1.8,'-o');
   text(1.2,1.8,'\leftarrow Anchor-C');





