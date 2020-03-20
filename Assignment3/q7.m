clear;clc;close all;

data = xlsread('Altitude.xlsx')
sz = size(data,1)

X = [ones(sz, 1) data(:,1) data(:,2)];
Y  = data(:,3)

train_X = X(1:900,:)
train_Y = Y(1:900,:)
test_X = X(901:1000,:)
test_Y = Y(901:1000,:)


theta = zeros(3, 1);
iterations = 300;
alpha = 0.00001;
[theta,errors,final_error] = gradientDescent(train_X, train_Y, theta, alpha, iterations,test_X,test_Y);
figure
plot(errors)
title("Simple gradient descent: alpha = 0.00001,iterations = 300,final error="+final_error)

theta = zeros(3, 1);
iterations = 1000;
alpha = 0.01;
col2 = (train_X(:,2)-mean(train_X(:,2)))/range(train_X(:,2))
col3 = (train_X(:,3)-mean(train_X(:,3)))/range(train_X(:,3))
norm_train_X = [ones(900,1) col2 col3]
col2 = (test_X(:,2)-mean(test_X(:,2)))/range(test_X(:,2))
col3 = (test_X(:,3)-mean(test_X(:,3)))/range(test_X(:,3))
norm_test_X = [ones(100,1) col2 col3]
[theta,errors,final_error] = gradientDescent(norm_train_X, train_Y, theta, alpha, iterations,norm_test_X,test_Y);
figure
plot(errors)
title("Mean normalized gradient descent: alpha = 0.01,iterations = 1000; final error="+final_error )

theta = zeros(3, 1);
iterations = 50;
alpha = 0.0001;
[theta,errors,final_error] = miniBatchGradientDescent(train_X, train_Y, theta, alpha, iterations,test_X,test_Y,150);
figure
plot(errors)
title("Mini batch gradient descent: alpha ="+alpha+",iterations ="+iterations+",final error="+final_error)

function [theta,errors,final_error] = gradientDescent(X, Y, theta, alpha, num_iters, test_X,test_Y)

  p = 1:size(test_X,1)
  predicted_outputs=zeros(size(test_X,1),1)
  errors = zeros(1,num_iters)
  nt = norm(test_Y)

  m = size(X,1)
  for iter = 1:num_iters
     k=1:m;

     j1=(1/m)*sum(  (theta(1)+ theta(2).*X(k,2) + theta(3).*X(k,3)) - Y(k))
     j2=(1/m)*sum(( (theta(1)+ theta(2).*X(k,2) + theta(3).*X(k,3)) - Y(k)).*X(k,2))
     j3=(1/m)*sum(( (theta(1)+ theta(2).*X(k,2) + theta(3).*X(k,3)) - Y(k)).*X(k,3))

     theta(1)=theta(1)-alpha*(j1);
     theta(2)=theta(2)-alpha*(j2);
     theta(3)=theta(2)-alpha*(j3);

     predicted_outputs(p) = sum(test_X(p,:)'.*theta)
     np = norm(predicted_outputs)
     errors(1,iter) =(abs(nt-np)/nt)*100
  end
  final_error = errors(1,num_iters)

end

function [theta,errors,final_error] = miniBatchGradientDescent(X, Y, theta, alpha, num_iters, test_X,test_Y,batch)

  p = 1:size(test_X,1)
  predicted_outputs=zeros(size(test_X,1),1)
  errors = zeros(1,num_iters)
  nt = norm(test_Y)

  m = size(X,1)
  for iter = 1:num_iters
    for tt = 0:batch:m-1
     k=tt+1:tt+batch;

     j1=(1/m)*sum(  (theta(1)+ theta(2).*X(k,2) + theta(3).*X(k,3)) - Y(k))
     j2=(1/m)*sum(( (theta(1)+ theta(2).*X(k,2) + theta(3).*X(k,3)) - Y(k)).*X(k,2))
     j3=(1/m)*sum(( (theta(1)+ theta(2).*X(k,2) + theta(3).*X(k,3)) - Y(k)).*X(k,3))

     theta(1)=theta(1)-alpha*(j1);
     theta(2)=theta(2)-alpha*(j2);
     theta(3)=theta(2)-alpha*(j3);

     predicted_outputs(p) = sum(test_X(p,:)'.*theta)
     np = norm(predicted_outputs)

     errors(1,iter) =(abs(nt-np)/nt)*100
   end
  end
  final_error = errors(1,num_iters)

end
