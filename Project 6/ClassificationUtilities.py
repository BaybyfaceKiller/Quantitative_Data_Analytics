# Name: Chenxu Liu
# SciNet username: tmp_cliu
# Description:
#  This script contains functions that are used to build classification models

# Create a function that reads a file into a dataframe and split
#   the data into training and testing set
def get_data(file_string):
    # import libraries
    import pandas as pd
    from sklearn.model_selection import train_test_split
    # print data information
    print('Gathering data from {}'.format(file_string))
    # read the file into a dataframe
    my_data=pd.read_csv(file_string)
    # extract features
    X=my_data.loc[:,my_data.columns != 'label']
    # extract targets
    y=my_data.loc[:,'label']
    # split training and testing data
    X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.33,random_state
    =0)
    # return training features, testing features, training targets, testing targets
    return X_train,X_test,y_train,y_test

# Create a function that train a classification model based on given arguments
def train_model(train_feature,train_target,model_name):
    # import libraries
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.linear_model import LogisticRegression
    from sklearn.neighbors import KNeighborsClassifier
    import keras.utils as ku
    import keras.models as km
    import keras.layers as kl
    import sklearn.ensemble as ske
    import xgboost as xgb
    # if the given argument for model_name is 'DT'
    if model_name == 'DT':
        # print model building information
        print('Building Decision Tree model')
        # initialize decision tree classifier
        dt=DecisionTreeClassifier()
        # fit the model with training data
        dt.fit(train_feature,train_target)
        # return the trained model
        return dt
    # if the given argument for model_name is 'LR'
    elif model_name == 'LR':
        # print model building information
        print('Building Logistic Regression model')
        # initialize logistic regression model
        lr=LogisticRegression(max_iter=500)
        # fit the model with training data
        lr.fit(train_feature,train_target)
        # return trained model
        return lr
    # if the given argument for model_name is 'NN'
    elif model_name=='NN':
        # print model building information
        print('Building Neural Network model')
        # transform the target into integers
        train_target=train_target.astype('int')
        # number of feaetures
        num_feature=train_feature.shape[1]
        # number of classes
        num_class=len(train_target.unique())
        # if multiclass classification
        if num_class > 2:
            train_target=train_target-1
            # one-hot encoding target
            train_target=ku.to_categorical(train_target)
        # build neural network with one hidden layer of 30 neurons
        model=km.Sequential()
        model.add(kl.Dense(30, input_dim = num_feature,activation = 'sigmoid'))
        if num_class == 2:
            model.add(kl.Dense(num_class,activation='sigmoid'))
        else:
            model.add(kl.Dense(num_class,activation='softmax'))
        model.compile(loss = 'mean_squared_error', optimizer = 'sgd', metrics = ['accuracy'])
        # train the model
        model.fit(train_feature,train_target,epochs=200,batch_size=24)
        # return trained model
        return model
    # if the given argument for model_name is 'Stack'
    elif model_name=='Stack':
        # print model building information
        print('Building Stacked model with DT, kNN and LR')
        # decision tree model
        dt=DecisionTreeClassifier()
        # kNN
        knn=KNeighborsClassifier(n_neighbors=3)
        # logistic Regression
        lr=LogisticRegression(max_iter=500)
        # stack models
        stack=[('kNN3',knn)]
        stack.append(('DT',dt))
        stack.append(('LR',lr))
        # initialize stacked model and set logistic regression as final estimator
        stacked=ske.StackingClassifier(estimators=stack,final_estimator=LogisticRegression(max_iter=500))
        # train the model
        stacked.fit(train_feature,train_target)
        # return trained model
        return stacked
    # if the given argument for model_name is 'XGB'
    elif model_name=='XGB':
        # print model building information
        print('Building XGBoost model')
        # xgboost model
        xgb_model=xgb.XGBClassifier()
        # train the model
        xgb_model.fit(train_feature,train_target)
        # return trained model
        return xgb_model

# Create function that trains kNN model and tunes hyperparameter
#  with 10-fold cross-validation
def hyperparam_tuning_knn(train_feature,train_target):
    # import libraries
    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.model_selection import cross_val_score
    import numpy as np
    # print model building information
    print('Building kNN model')
    # create a list to store the average score for each k
    average_score_list=[]
    # iterate through each k value
    for k in range(1,32):
        # initialize kNN classifier
        knn=KNeighborsClassifier(n_neighbors=k)
        # calcualte average score
        score=np.mean(cross_val_score(knn,train_feature,train_target,cv=10))
        # append the average score to list
        average_score_list.append(score)
    # find the optimal k value with highest average score
    best_k=np.argmax(average_score_list)+1
    # print the optimal k value
    print('Optimal value of k is ',best_k)
    # initialize kNN classifier with the optimal k value
    knn=KNeighborsClassifier(n_neighbors=best_k)
    # train the kNN classifier
    knn.fit(train_feature,train_target)
    # return trained model
    return(knn)

# Create function that take the trained model and make prediction for testing data
#  and return confusion matrix and accuracy score
def model_performance(trained_model,test_feature,test_target,model_name):
    # import libraries
    from sklearn.metrics import confusion_matrix
    from sklearn.metrics import accuracy_score
    import numpy as np
    # number of class
    num_class=len(np.unique(test_target))
    # if the model is not neural network
    if model_name != 'NN':
        # make prediction on testing data using trained model
        prediction=trained_model.predict(test_feature)
    # if the model is neural network
    else:
        # make prediction on testing data using trained model
        result=trained_model.predict(test_feature)
        # transform prediction into one column
        prediction=np.argmax(result,axis=1)
        # for multiclass classification
        if num_class > 2:
            # convert index to label
            prediction = prediction +1
    # calcualte confusion confusion_matrix
    cm=confusion_matrix(test_target,prediction)
    # calcualte accuracy score
    accuracy=accuracy_score(test_target,prediction)
    # return confusion matrix and accuracy score
    return cm,accuracy

# Create function that calcualte AUC score
def area_under_curve(trained_model,test_feature,test_target):
    # import library
    from sklearn.metrics import roc_auc_score
    # if the number of category is 2
    if len(trained_model.classes_) == 2:
        # make prediction for testing data
        prediction=trained_model.predict(test_feature)
        # calculate AUC score
        auc=roc_auc_score(test_target,prediction)
        # return AUC score
        return auc
    # if the number of category is greater than 2
    else:
        # do nothing
        pass
