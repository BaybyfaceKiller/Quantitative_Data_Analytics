
# Description:
#  This script builds classification model using functions in ClassificationUtilities.py
#      with given arguments

# import library and functions in utility file
import argparse
from ClassificationUtilities import (get_data, train_model, hyperparam_tuning_knn,
                                      model_performance,area_under_curve)
# build argparser
parser=argparse.ArgumentParser()
# add argument for file string
parser.add_argument('file_string',help='URL or filename')
# add argument for model name
parser.add_argument('model',help='Select a model to use')
# add optional argument for AUC score
parser.add_argument('--AUC',help='AUC for the model and test data',
                     action='store_true')
# parse arguments
args=parser.parse_args()
# get file name
my_file=args.file_string
# get model name
my_model=args.model
# get argument for AUC
if_auc=args.AUC
# check if the given model name is acceptable:
if my_model not in ['DT','LR','kNN','NN','Stack','XGB']:
    # print error message
    print('Error: Given model is not acceptable.')
    print('Acceptable model arguments:','DT, LR, kNN','NN','Stack','XGB')
    # quit
    quit()
# get training features, testing features, training target and testing target
train_data,test_data,train_target,test_target=get_data(my_file)
# if the model is kNN
if my_model == 'kNN':
    # train the model with hyperparameter tuning
    trained_model=hyperparam_tuning_knn(train_data,train_target)
# if the model is not kNN
else:
    # train the model
    trained_model=train_model(train_data,train_target,my_model)
# get confusion matrix and accuracy score
cm,accuracy=model_performance(trained_model,test_data,test_target,my_model)
# print the confusion matrix
print('Confusion matrix:')
print(cm)
# print the accuracy score
print('Model accuracy: {}'.format(accuracy))
# if AUC argument is given
if if_auc:
    # if not using neural network
    if my_model != 'NN':
        # if the trained model need to predict for more than 2 categories
        if len(trained_model.classes_) != 2:
            # do nothing
            pass
        # if the trained model only need to predict for 2 categories
        else:
            # get AUC score
            auc=area_under_curve(trained_model,test_data,test_target)
            # print the AUC score
            print('ROC AUC: {}'.format(auc))
