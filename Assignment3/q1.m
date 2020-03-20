clear;
clc;
data = csvread('houses.csv')
%making input and output
X_inp = [ones(47,1) data(:,1) data(:,2)]
Y = data(:,3)
%plotting the original input values
figure
scatter3(data(:,1),data(:,2),Y,'filled')
hold on;
% dividing into test and train data(90-10)
train_X = X_inp(1:42,:)
train_Y = Y(1:42,:)
test_X = X_inp(43:47,:)
test_Y = Y(43:47,:)
%generating the coefficients
train_Xt = train_X.'
b = inv(train_Xt*train_X)*train_Xt*train_Y
%plotting the prediction plane
x_coord = linspace(0,4500,4501)
y_coord = linspace(0,5,6)
[XX,YY] = meshgrid(x_coord,y_coord)
preds = b(2).*XX+b(3).*YY
preds = preds+b(1)
mesh(preds)


%for part 1
input = [1 1400 4]
output = sum(input'.*b)

%for part 2
col2 = (train_X(:,2)-mean(train_X(:,2)))/range(train_X(:,2))
col3 = (train_X(:,3)-mean(train_X(:,3)))/range(train_X(:,3))
norm_train_X = [ones(42,1) col2 col3]
norm_train_Xt = norm_train_X.'
b_norm = inv(norm_train_Xt*norm_train_X)*norm_train_Xt*train_Y

inp2 = (1400-mean(train_X(:,2)))/range(train_X(:,2))
inp3 = (4-mean(train_X(:,3)))/range(train_X(:,3))
norm_input = [1 inp2 inp3]
norm_output = sum(norm_input'.*b_norm)


% for part 3
input_mean = [1 mean(train_X(:,2)) mean(train_X(:,3))]
output_mean = sum(input_mean'.*b)
y_mean = mean(train_Y)


% for testing our prediction = calculating the L2 norm
predicted_outputs=zeros(5,1)
for i = 1:5
    predicted_outputs(i) = sum(test_X(i,:)'.*b)
end

n_pred = norm(predicted_outputs)
n_actual = norm(test_Y)
(n_pred-n_actual)/n_actual*100
% predicted norm is 5.8% different from actual norm
