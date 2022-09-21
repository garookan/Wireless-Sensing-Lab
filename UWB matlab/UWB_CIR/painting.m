%%
title("0");
figure(1)
subplot(2,1,1)
plot(sqrt(x(739:739+30,1).^2+x(739:739+30,2).^2))
subplot(2,1,2)
plot(sqrt(x(1371:1371+30,1).^2+x(1371:1371+30,2).^2))
figure(2)
subplot(2,1,1)
plot(sqrt(x(739:739+30,3).^2+x(739:739+30,4).^2))
subplot(2,1,2)
plot(sqrt(x(1371:1371+30,3).^2+x(1371:1371+30,4).^2))

%%
figure(1)
stem(sqrt(x(:,1).^2+x(:,2).^2))
figure(2)
stem(sqrt(x(:,3).^2+x(:,4).^2))
figure(3)
stem(sqrt(x(:,5).^2+x(:,6).^2))
figure(4)
stem(sqrt(x(:,7).^2+x(:,8).^2))


%%
figure(2)
subplot(2,1,1)
stem(sqrt(x(:,1).^2+x(:,2).^2))
title("left");
subplot(2,1,2)
stem(sqrt(x(:,3).^2+x(:,4).^2))
title("right");


%%
figure(3)
title("+40");
subplot(2,1,1)
stem(sqrt(x(:,9).^2+x(:,10).^2))
subplot(2,1,2)
stem(sqrt(x(:,11).^2+x(:,12).^2))
%%
figure(4)
plot(sqrt(x1(:,1).^2+x1(:,2).^2))  % �ݿ��� ������


%%
figure(4)
subplot(5,1,1)
stem(sqrt(z(:,1).^2+z(:,2).^2))
subplot(5,1,2)
stem(sqrt(z(:,3).^2+z(:,4).^2))
subplot(5,1,3)
stem(sqrt(z(:,5).^2+z(:,6).^2))
subplot(5,1,4)
stem(sqrt(z(:,7).^2+z(:,8).^2))
subplot(5,1,5)
stem(sqrt(z(:,9).^2+z(:,10).^2))
%%
figure(7)
subplot(5,1,1)
stem(sqrt(z1(:,1).^2+z1(:,2).^2))
subplot(5,1,2)
stem(sqrt(z1(:,3).^2+z1(:,4).^2))
subplot(5,1,3)
stem(sqrt(z1(:,5).^2+z1(:,6).^2))
subplot(5,1,4)
stem(sqrt(z1(:,7).^2+z1(:,8).^2))
subplot(5,1,5)
stem(sqrt(z1(:,9).^2+z1(:,10).^2))
%%
figure(5)
subplot(5,1,1)
stem(sqrt(x(:,1).^2+x(:,2).^2))
subplot(5,1,2)
stem(sqrt(x(:,3).^2+x(:,4).^2))
subplot(5,1,3)
stem(sqrt(x(:,5).^2+x(:,6).^2))
subplot(5,1,4)
stem(sqrt(x(:,7).^2+x(:,8).^2))
subplot(5,1,5)
stem(sqrt(x(:,9).^2+x(:,10).^2))
figure(6)
subplot(5,1,1)
stem(sqrt(y(:,1).^2+y(:,2).^2))
subplot(5,1,2)
stem(sqrt(y(:,3).^2+y(:,4).^2))
subplot(5,1,3)
stem(sqrt(y(:,5).^2+y(:,6).^2))
subplot(5,1,4)
stem(sqrt(y(:,7).^2+y(:,8).^2))
subplot(5,1,5)
stem(sqrt(y(:,9).^2+y(:,10).^2))

%%
subplot(2,1,1)
plot(x(:,1),x(:,2))
subplot(2,1,2)
plot(y(:,1),y(:,2))