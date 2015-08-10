Deep Learning Bitmaps to PCM, Audio fun with deep belief networks
=================================================================

https://archive.org/details/DeepLearningBitmaptoPCM

Can we learn from video frames to produce audio? Our training set can
be synchronized audio and video, whereby we train a deep belief
network to convert a bitmap of a video frame into PCM audio.

My former master's student Gregory Burlet wrote a masters thesis on
Guitar transcription using deep learning. I thought I'd join the fray
and try an idea I had with deep learning. Prior authors had relied on
relatively simple features or reduced representations of data, such as
re-sizing a bitmap or down-sampling audio, and used that raw data as
features instead of more complicated summaries. Gregory used short
time fourier transforms (STFTs) to describe the input audio. I decided
not to use audio as input, I wanted to associate video frame with
audio.

Deep Learning Setup
-------------------

Thus I set up a DBN like so:

    Input: 64x64 gray scaled pixels -> 
                 deep belief network -> 
                   PCM audio (floating point samples)
    
The training data / validation data is whatever video I feel like.
Different videos have different results. The output is the PCM audio
of that frame. I thought wow gee if the DBN could produce PCM audio
that would pretty interesting, there's a lot of complicated things
that go on in audio signals and if a DBN can do it well that'll be
really impressive.

Input frames were scaled down too 64x64 gray scaled bitmaps with each
pixel represented as a value within [0,1]. Audio was monaural and
resampled to 22050hz PCM floats.

Training took between 2000 and 7000 minutes per brain. Some brains
were simple 4096 inputs -> 1000 units -> 735 outputs. Some were more
complicated such as 4096 -> 1000 -> 1000 -> 1000 -> 735 or 4096 ->
2048 -> 1000 -> 1000 -> 735.

Training Data
-------------

In this repository I have provided numerous video examples and brains
that you are free to play with.

* armstrong-basic - This is a brain trained off of a video of John
  Armstrong et al. playing rock music with a theremin. See
  [armstrong-basic/armstrong-basic.avi.webm](armstrong-basic/armstrong-basic.avi.webm)
  or https://www.youtube.com/watch?v=PWvUetfc8Ss.
  Network 4096 -> 1000 -> 735
* lines-small - lines for clarinet by Jon Osborne a local Edmonton
  animator. Network 4096 -> 1000 -> 735. See https://vimeo.com/33085567
* osborne-combined-big - trained off of a larger compilation of Jon
  Osborne videos:
  * Seeing a sound quickly https://vimeo.com/132365424
  * Pulse https://vimeo.com/115228257
  * Ode to Jimi https://vimeo.com/113761092
  * Lines for Clarinet https://vimeo.com/33085567    
* seeing-a-sound-shallow trained from Seeing a sound quickly
  https://vimeo.com/132365424
* KUNGFURY -- Trained on KUNG FURY the movie. 4096 -> 2000 -> 1500 ->
  1000 -> 735
* lines - - lines for clarinet by Jon Osborne. See
  https://vimeo.com/33085567 . 4096 -> 1000 -> 1000 -> 1000 -> 735
* ramshackletyping. Trained on a video I shot of the Olm? Typing.  Network 4096 -> 1000 -> 735
* seeing-a-sound-deeper from Seeing a sound quickly
  https://vimeo.com/132365424 by Jon Osborne.
  Network 4096 -> 1000 -> 1000 -> 1000 -> 735

Observations
------------

It produces audio! The audio isn't great. The audio often responds to
action on the screen. The audio doesn't respond to theme or content.
There is no memory. There is often repeating annoying noises.

It took between 2000 and 7000 minutes to train each brain on a CPU.
Kung Fury wasn't finished training by the time this was written.

The audio is awful, there's often 30hz harmonics throughout the audio
due to the cutting off of frame sounds and no windowing. Windowing can
improve the situation but still induces 30hz noise.

I used CSound to reinterpret the sound as granular synthesis, that
worked better but lost it's timelyness.

Suggestions
===========

Every training set should include 30 seconds or so of black screen and
white screens with silent audio. That way the system would keep black
screens quieter how we expect them.

Use history, this is a very stateless approach. An RNN might be a
great idea.

Is PCM the most effecient representation? If I want to produce
sonically interesting perhaps I might do better in frequency space
(STFT) or a vocoder space.

Color and past frames were not included. Furthermore no analysis of
the frames were used either. Perhaps an Eigen-faces style of operation
would work.


Conclusions
===========

Briefly I'll conclude, without prior context of prior
frames or prior sound that was already output, the quality of the
audio output is pretty low. Either we need way more data for training,
which I don't want to spend time on, or we need to add more context to
the frame. There's an inherent independence assumption: 1 frame of
video induces 1 frame of audio. But consider that 1 guitar pluck
induces an audible signal for a lot longer than the guitar pluck, so
there's a slight problem.

Attribution
===========

Jon Osborne is a local animator who I have been working with. His
animation is great, but I'm not sure he likes any of the sounds I put
to them :(

* osborne-lines taken from Lines for Clarinet https://vimeo.com/33085567
* osborne-etude-1 and osborne-etude-2 taken from Etudes https://vimeo.com/32493387
* osborne ode-to-jimmie taken from Ode to Jimi https://vimeo.com/113761092
* osborne-pulse -- taken from Pulse https://vimeo.com/115228257
* osborne-seeing-sound -- taken from Seeing a sound quickly
  https://vimeo.com/132365424

These videos are (C) Jon Osborne -- assume similar rules to CC-BY-NC-ND

Public domain images from Archive.org
* 015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv
* 114-tones.1397368837.20976-out.114-tones.wav.audio.mkv
* 1408297309.27876-out.caffeine.wav.audio.mkv
* 1408304868.8993-out.caffeine.wav.audio.mkv

Assume Public domain

Abram's photos and images and video
* 20secondBorys.mp4
* belch-kitchen-sample.mp4
* drone-sample.mp4 -- video of the Olm
* govid3-oldsketch.mkv
* MVI_9117.mov
* osborne-seeing-sound.mp4
* spikey-mouth-loop.mkv
* VID_20130404_003435.mp4.1384674117.corpus.mkv
* VID_20130531_132327.mp4.1384676233.corpus.mkv

Assume CC-BY 4.0 Abram Hindle

Public domain from Archive.org
* alphabet-conspiracy.mp4 -- Alphabet Conspiracy
* Bimbo's_Initiation_1931.mp4 -- Max Ernst Bimbo's Initiation 1931

I think these might have some images from Evelyn Berg in it:

* 1392098818.mkv 
* 1392098671.mkv
* 1392099724.mkv

Assume CC-BY-NC.

Some ideas and inspiration are from Gregory Burlet:

https://peerj.com/preprints/1193/

Burlet G, Hindle A. (2015) Isolated instrument transcription using a
deep belief network. PeerJ PrePrints 3:e1455
https://dx.doi.org/10.7287/peerj.preprints.1193v1

How to use this stuff
=====================

This repository is for support files and examples of applying mostly
deep multilayered perceptrons (deep belief networks) to the task of
converting video frames to PCM.


Training is simple, run pickler.py on a video and generate video.pkl
and audio.pkl. Then run theanet.py to learn a brain between the 2.
This can take more than a week for 30 minutes of video. Once a
theanet.py.net.pkl is produce you can run render.sh and produce a
rendered version of a video.

There are 2 render modes, raw and granular synthesis. Raw has issues
with 30 hz harmonics (30fps) and granular synthesis isn't always on
time.

Current observations: the audio produced is high frequency, but the
length of the output is not enough to produce continuous low frequency
tones anyways. A lot of the output is noise.

Latest source code should be here:

https://github.com/abramhindle/dbn-bitmap-to-pcm

Assume GPL3.0 license on all source code.

Assume GPL3.0 on all DBN pickles.
