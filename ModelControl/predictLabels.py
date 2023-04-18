import tensorflow as tf
from tensorflow import keras
import matplotlib.pyplot as plt
import numpy as np
import numpy.random as npr
import joblib 
import cv2 
import os
import time
import datetime

import firebase_admin
from firebase_admin import db,  storage

class Emotion_ML:
  def __init__(self):
    self.file_name = ""
    self.labels = []
    self.images = []

  def dbObj(self):
      cred_obj = firebase_admin.credentials.Certificate("cue-cetera-726df-firebase-adminsdk-z8vba-e4c583ce09.json")
      databaseURL = 'https://cue-cetera-726df-default-rtdb.firebaseio.com/'
      bucket = 'cue-cetera-726df.appspot.com'
      default_app = firebase_admin.initialize_app(cred_obj, {
          'databaseURL': databaseURL,
          'storageBucket': bucket
      })

  def pull_from_dB(self):
      dbObj()
      ref = ref = db.reference("Videos/paths")
      path = ref.order_by_child('Path').get()
      path_val = ""

      for key, val in path.items():
          path_val = val
          path_val = path_val['Path']

      if path_val[0] == "\\":
        currPath = path_val[1:]

      source_blob_name = currPath

      # The path to which the video should be downloaded
      destination_file_name = r"videoAnalysis.mp4"

      bucket = storage.bucket()
      blob = bucket.blob(source_blob_name)
      blob.download_to_filename(destination_file_name)

      return currPath

  def delete_db(self):
      for key, val in data.items():
          delete_user_ref = ref.child(key)
          delete_user_ref.delete()

  def upload_img(self, file_name):
      bucket = storage.bucket()
      blob = bucket.blob(fileName)
      blob.upload_from_filename(fileName)
      return blob

  def delete_img(self, blobs):
      for blob_item in blobs:
        blob_item.delete()

  def vid_to_imgs(self, file_name):
    self.file_name = file_name
    # Create imgs folder
    if not os.path.isdir("imgs"):
        os.mkdir("imgs")
    FPS = 10
    # Read the video and its fps
    video = cv2.VideoCapture(file_name)
    vid_fps = video.get(cv2.CAP_PROP_FPS)
    if vid_fps < FPS:
        FPS = vid_fps
        
    vid_length = video.get(cv2.CAP_PROP_FRAME_COUNT) / vid_fps
    
    steps = []
    for i in np.arange(0, vid_length, 1/FPS):
        steps.append(i)
    
    cnt = 0
    curr_step = 0
    success = True
    while success:
        success,image = video.read()
        if not success:
            break
        # Get the length of clip
        frame_len = cnt/vid_fps
        # Increment step
        if(curr_step == len(steps)):
            break
        else:
            length_ = steps[curr_step]

        if frame_len >= length_:
            # save frame if length is <= current frame length
            
            #format filename
            timeStamp = str(datetime.timedelta(seconds=frame_len))
            try:
                timeStamp, ms = timeStamp.split(".")
                ms = int(ms)
                ms = round(ms/1e4)
                timeStamp = f"{timeStamp}.{ms:02}".replace(":", "-")
            except ValueError:
                timeStamp = (timeStamp + ".00").replace(":", "-")
            # save image to folder
            cv2.imwrite(os.path.join("imgs/", f"frame{timeStamp}.jpg"), image)
            curr_step +=1
        cnt +=1
        
        
        
  def predict_emotions(self, img_dir):
    # emotion map
    emotions = {0:'Affection', 1:'Anger', 2:'Annoyance', 3:'Anticipation',
               4:'Aversion', 5:'Confidence',6:'Disapproval', 7:'Disconnection',
               8:'Disquietment', 9:'Doubt/Confusion', 10:'Embarrassment',
               11:'Engagement',12:'Esteem', 13:'Excitement', 14:'Fatigue',
               15:'Fear', 16:'Happiness', 17:'Pain', 18:'Peace', 19:'Pleasure',
               20:'Sadness', 21:'Sensitivity', 22:'Suffering', 23:'Surprise',
               24:'Sympathy', 25:'Yearning', 26:'Disgust', 27:'Neutral'}

    # import model
    model3 = joblib.load('training/models/Model3_trained.pkl');
    num_imgs = len([name for name in os.listdir(img_dir) if os.path.isfile(os.path.join(img_dir, name))])
    imgs = []
    for image in os.listdir(img_dir):
        img = cv2.imread(os.path.join(img_dir, image))
        arr = cv2.resize(img, (48, 48), interpolation=cv2.INTER_CUBIC)
        imgs.append(arr)

        curr_img = img_dir + image
        blobs = []
        curr_blob = upload_img(curr_img)
        blobs.append(curr_blob)
    
    self.images = imgs
    # reshape image
    imgs = np.array(imgs).reshape(-1, 48, 48, 3)

    # preprocess data for model
    imgs_rs = keras.applications.mobilenet_v2.preprocess_input(imgs)

    #predict labels
    y_imgs = np.argmax(model3.predict(imgs_rs), axis=1)

    self.labels = []
    for i in range(len(y_imgs)):
        self.labels.append(emotions[y_imgs[i]])


if __name__ == "__main__":
    model = Emotion_ML()
    fileName = pullFromDB()
    model.vid_to_imgs(fileName)
    model.predict_emotions("imgs/")
    labels = model.labels
