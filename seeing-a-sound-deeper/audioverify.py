import sys
import cv2
import numpy as np
from numpy import *
import random
import time
import pickle
import os.path
import scipy.io
import scipy.io.wavfile
from scikits.audiolab import play
import theanets
import pickle
import numpy as np
import scikits.audiolab

audio = pickle.load(file("audio.pkl"))
outwav = scikits.audiolab.Sndfile("audio.wav",mode='w',format=scikits.audiolab.Format(),channels=1,samplerate=22050)
for i in range(0,audio.shape[0]):
    outwav.write_frames(audio[i])
outwav.sync()
