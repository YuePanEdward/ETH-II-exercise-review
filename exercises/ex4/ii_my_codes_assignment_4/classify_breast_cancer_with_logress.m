% Using Logistic Regression
% import and preprocess the data
my_data=csvread('../data/data.csv');

% TODO : Remove or inteprotate missing data
% actually there's no missing values in the dataset
% So nothing would be done here.

% Split data for cross validation
training_ratio=0.75;

X=my_data(:,2:10);
Y=my_data(:,11);
Y(Y==4)=1; % malignant
Y(Y==2)=0; % benign

total_sample_num=size(X,1);
training_sample_num=ceil(training_ratio*total_sample_num);
test_sample_num=total_sample_num-training_sample_num;

accuracy=[];
% 4-fold cross validation
for i=0:3
  training_sample_index= linspace(1,total_sample_num,total_sample_num);
  test_sample_index=linspace(i*test_sample_num+1,(i+1)*test_sample_num,test_sample_num);
  training_sample_index(:,test_sample_index)=[];
  
  X_train=X(training_sample_index,:);
  X_test=X(test_sample_index,:);
  Y_train=Y(training_sample_index,:);
  Y_test=Y(test_sample_index,:);

  % Train
  model = ii_train_logress(X_train,Y_train);

  % Test
  Y_predict_test = ii_test_logress(model,X_test);
  Y_predict_test_0_1 = Y_predict_test>0.5;

  % Calculate accuracy
  Y_diff=Y_predict_test_0_1-Y_test;
  TP=sum(Y_diff==0);
  accuracy(i+1)=TP/test_sample_num;
end
% Get mean accuracy for 4 folds
mean_accuracy=mean(accuracy)
