#JSONify It is a CSV to JSON converter designed to help you easily convert tabular data from spreadsheets,
#CSV files or any delimited file into JSON.
from flask import Flask, jsonify, request
#Joblib is a set of tools to provide lightweight pipelining in Python
import joblib
#In computer programming, pandas is a software library written for the Python programming language for data
#manipulation and analysis.
import pandas as pd
#NumPy is a library for the Python programming language, adding support for large, multi-dimensional arrays
#and matrices, along with a large collection of high-level mathematical functions to operate on these arrays
import numpy as np
#Scikit-learn is a free software machine learning library for the Python programming language.
from sklearn import *
#Cross-origin resource sharing (CORS) is a mechanism that allows restricted resources on a web page to be requested
#from another domain outside the domain from which the first resource was served.
from flask_cors import CORS


#__name__ is just a convenient way to get the import name of the place the app is defined. Flask uses the import name to
#know where to look up resources, templates, static files, instance folder, etc.
app = Flask(__name__)

CORS(app)
@app.route('/predict',methods = ['POST'])
def predict():
    json = request.json['test']


if __name__=='__main__':
    clf = joblib.load('ds_model.pkl')
    app.run()
    