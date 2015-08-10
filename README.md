Deep Learning Bitmaps to PCM, Audio fun with deep belief networks
=================================================================

* [Archive.org Repo](https://archive.org/details/DeepLearningBitmaptoPCM)
* [Github Repo of this post](https://github.com/abramhindle/dbn-bitmap-to-pcm-blog-post)
* [Directory of Files](https://archive.org/download/DeepLearningBitmaptoPCM/)

Can we learn from video frames to produce audio? Our training set can
be synchronized audio and video, whereby we train a deep belief
network to convert a bitmap of a video frame into PCM audio.

My former master's student Gregory Burlet wrote a masters thesis on
Guitar transcription using deep learning. I thought I'd join the fray
and try an idea I had with deep learning. Prior authors had relied on
relatively simple features or reduced representations of data, such as
re-sizing a bitmap or down-sampling audio, and used that raw data as
features instead of more complicated summaries. Gregory used short
time Fourier transforms (STFTs) to describe the input audio. I decided
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
  [armstrong-basic/armstrong-basic.avi.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic.avi.webm)
  or [youtube](https://www.youtube.com/watch?v=PWvUetfc8Ss).
  Network 4096 -> 1000 -> 735
* lines-small - lines for clarinet by Jon Osborne a local Edmonton
  animator. Network 4096 -> 1000 -> 735. See [vimeo](https://vimeo.com/33085567)
* osborne-combined-big - trained off of a larger compilation of Jon Osborne videos:
  * [Seeing a sound quickly on vimeo](https://vimeo.com/132365424)
  * [Pulse on vimeo](https://vimeo.com/115228257)
  * [Ode to Jimi](https://vimeo.com/113761092)
  * [Lines for Clarinet](https://vimeo.com/33085567)  
* seeing-a-sound-shallow trained from [Seeing a sound quickly](https://vimeo.com/132365424)
* KUNGFURY -- Trained on KUNG FURY the movie. 4096 -> 2000 -> 1500 ->
  1000 -> 735 . See [kungfury.com](http://www.kungfury.com/) and [youtube](https://www.youtube.com/watch?v=bS5P_LAqiVg)
* lines - - lines for clarinet by Jon Osborne. See
  [vimeo](https://vimeo.com/33085567) . 4096 -> 1000 -> 1000 -> 1000 -> 735
* ramshackletyping. Trained on a video I shot of the Olm? Typing.  Network 4096 -> 1000 -> 735
* seeing-a-sound-deeper from Seeing a sound quickly
  [vimeo](https://vimeo.com/132365424) by Jon Osborne.
  Network 4096 -> 1000 -> 1000 -> 1000 -> 735

Observations
============

It produces audio! The audio isn't great. The audio often responds to
action on the screen. The audio doesn't respond to theme or content.
There is no memory. There is often repeating annoying noises.

It took between 2000 and 7000 minutes to train each brain on a CPU.
Kung Fury wasn't finished training by the time this was written.

The audio is awful, there's often 30hz harmonics throughout the audio
due to the cutting off of frame sounds and no windowing. Windowing can
improve the situation but still induces 30hz noise.

I used CSound to reinterpret the sound as granular synthesis, that
worked better but lost it's on-time edge. Granular synthesis smears
events.

See rendered examples section at the end of this document to see all
rendered examples.

Armstrong-basic
---------------

Trained on   [armstrong-basic/armstrong-basic.avi.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic.avi.webm)   or [youtube](https://www.youtube.com/watch?v=PWvUetfc8Ss). This is A   complicated scene filmed from a camera, not a lot visual difference.  This I think leads to really blaring output for unseen animations.

For Alphabet conspiracy raw sounds awful, but the granular synthesis
seems to work with the talking xray.

* [Raw](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [Granular](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic-alphabet-conspiracy.mp4-granular
  deeplearn.mkv.webm)

Osborne's Etudes come out very loud but interesting:

* [Raw](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [Granular](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)

I like the on-time response seen in the hand animation Ode to Jimi:

*  [Raw](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)

Kung Fury
---------

See [kungfury.com](http://www.kungfury.com/) and [youtube](https://www.youtube.com/watch?v=bS5P_LAqiVg) .

A large dataset seems to produce more pleasant PCM output.

* [1392098818.mkv](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392098818.mkv-deeplearn.mkv.webm)

Some of the granular synthesis seems quite appropriate:

[1392099724.mkv](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392099724.mkv-granular-deeplearn.mkv.webm)

20 second borys did not work so well:
[Raw](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-20secondBorys.mp4-deeplearn.mkv.webm)

Human figures seem to have more effect on the sound

* [Raw](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-alphabet-conspiracy.mp4-deeplearn.mkv.webm)

Fire sounds pretty good.

* [Fire](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-MVI_9117.mov-deeplearn.mkv.webm)

Kung Fury seems like a better sounding dataset / brain than others.
Perhaps more data and deeper networks are much better?

Lines and lines-small
---------------------

[Lines for clarinet by Jon Osborne](https://vimeo.com/33085567)

Both do quite well trained on themselves:

* [lines](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-lines.mp4-deeplearn.mkv.webm)
* [lines-small](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-lines.mp4-deeplearn.mkv.webm)

But the smaller network seems to produce more interesting sound with
Osborne's seeing sound:

* [lines](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [lines-small](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-seeing-sound.mp4-deeplearn.mkv.webm)

Perhaps I need to ensure that I'm properly training my network given
the performance of the shallower network.

Osborne-combined-big
--------------------

This dataset was a 15 minute long concatenation of some of the works
of Jon Osborne. The results tend to sound a lot like the other
networks.

* [Example](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-belch-kitchen-sample.mp4-deeplearn.mkv.webm)

Fire sounds pretty good.

* [Fire](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-MVI_9117.mov-deeplearn.mkv.webm)

For granular synthesis Etude 2 stands out:

* [Etude2](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [Lines](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-lines.mp4-granular-deeplearn.mkv.webm)

ramshackletyping
----------------

This one illustrates what a lack of variation in training data can do. Just brutal noise.

Here's some of the better tracks (less noise, still bad):

* [20secondBorys](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [Ode to Jimmie](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)

Essentially if you want really aggressive sounds, maybe train on less and overfit to the input?

Here's it overfitting to itself:

* [ramshackletyping](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-ramshackletyping.mov-deeplearn.mkv.webm)

Seeing a sound quickly
----------------------

One problem with training on this video is there isn't a lot of variation. It is very binary, on or off.

* [deep etude1](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [shallow etude1](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)

There seems to be little differentiation between deep and shallow in this case.

The lines for clarinet video is similar to the seeing a sound quickly video and works quite well:

* [deep lines](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-lines.mp4-deeplearn.mkv.webm)
* [shallow lines](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-lines.mp4-deeplearn.mkv.webm)

Discussion
----------

Activity of black is a natural choice, scratched film seems like a
good input.

A wider range of training inputs leads to a more robust output, but a
tighter higher accuracy brain seems to produce sonically interesting
results.

In general everything sounds pretty similar so I am not impressed by
the results of this experiment.

The difference between shallow and deep networks is not really that
sonically evident.

A common interpretation seems to be that white is loud and black is
not. This could be a problem.

Suggestions
===========

This experiment sounds interesting and horrible at the same time! What
can be done to improve the sound?

* Every training set should include 30 seconds or so of black screen
and white screens with silent audio. That way the system would keep black
screens quieter how we expect them.

* Use history, this is a very stateless approach. An RNN might be a
great idea.

* Is PCM the most effecient representation? If I want to produce
sonically interesting perhaps I might do better in frequency space
(STFT) or a vocoder space.

* Color and past frames were not included. Furthermore no analysis of
the frames were used either. Perhaps an Eigen-faces style of operation
would work where by the bitmaps Eigen vectors / PCA components are
used.


Conclusions
===========

Briefly I'll conclude, without prior context of prior frames or prior
sound that was already output, the quality of the audio output is
pretty low. Either we need way more data for training, which I don't
want to spend time on, or we need to add more context to the frame.
There's an inherent independence assumption: 1 frame of video induces
1 frame of audio. But consider that 1 guitar pluck induces an audible
signal for a lot longer than the guitar pluck, so there's a slight
problem.

Yet what this shows is that you can produce associations even if it is
slightly overfit and they can have some musical value.

We do not recommend generating raw PCM data, intermediate
representations might be more appropriate.

Attribution
===========

Jon Osborne is a local animator who I have been working with. His
animation is great, but I'm not sure he likes any of the sounds I put
to them :(

* osborne-lines taken from [Lines for Clarinet](https://vimeo.com/33085567)
* osborne-etude-1 and osborne-etude-2 taken from [Etudes](https://vimeo.com/32493387)
* osborne ode-to-jimmie taken from [Ode to Jimi](https://vimeo.com/113761092)
* osborne-pulse -- taken from [Pulse](https://vimeo.com/115228257)
* osborne-seeing-sound -- taken from [Seeing a sound quickly](https://vimeo.com/132365424)

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

Many ideas and inspiration are from Gregory Burlet:

[https://peerj.com/preprints/1193/](https://peerj.com/preprints/1193/)

Burlet G, Hindle A. (2015) Isolated instrument transcription using a
deep belief network. PeerJ PrePrints 3:e1455
[https://dx.doi.org/10.7287/peerj.preprints.1193v1](https://dx.doi.org/10.7287/peerj.preprints.1193v1)

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

* [https://github.com/abramhindle/dbn-bitmap-to-pcm](https://github.com/abramhindle/dbn-bitmap-to-pcm)
* [Github Repo of this post](https://github.com/abramhindle/dbn-bitmap-to-pcm-blog-post)

Assume GPL3.0 license on all source code.

Assume GPL3.0 on all DBN pickles.

Rendered Examples
=================

* [armstrong-basic/armstrong-basic-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1392098671.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1392098671.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1392098818.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1392098818.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1392099724.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1392099724.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-20secondBorys.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic.avi-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic.avi-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic.avi.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic.avi.webm)
* [armstrong-basic/armstrong-basic-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-drone-sample.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-MVI_9117.mov-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-etude-1.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-etude-1.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-etude-1.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-lines.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-pulse.mp4-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
* [armstrong-basic/armstrong-basic-vtest.avi-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/armstrong-basic/armstrong-basic-vtest.avi-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392098671.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392098671.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392098818.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392098818.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392099724.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1392099724.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-20secondBorys.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-drone-sample.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-MVI_9117.mov-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-lines.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-pulse.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [KUNGFURY/KUNGFURY-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/KUNGFURY/KUNGFURY-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [lines/20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/20secondBorys.mp4-deeplearn.mkv.webm)
* [lines/20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [lines/lines-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [lines/lines-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1392098671.mkv-deeplearn.mkv.webm)
* [lines/lines-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1392098671.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1392098818.mkv-deeplearn.mkv.webm)
* [lines/lines-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1392098818.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1392099724.mkv-deeplearn.mkv.webm)
* [lines/lines-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1392099724.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [lines/lines-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [lines/lines-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [lines/lines-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [lines/lines-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-drone-sample.mp4-deeplearn.mkv.webm)
* [lines/lines-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [lines/lines-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-MVI_9117.mov-deeplearn.mkv.webm)
* [lines/lines-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [lines/lines-osborne-etude-1.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-etude-1.mp4-deeplearn.mkv.webm)
* [lines/lines-osborne-etude-1.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [lines/lines-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-lines.mp4-deeplearn.mkv.webm)
* [lines/lines-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [lines/lines-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-pulse.mp4-deeplearn.mkv.webm)
* [lines/lines-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [lines/lines-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [lines/lines-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [lines/lines-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [lines/lines-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [lines/lines-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [lines/lines-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines/lines-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1392098671.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1392098671.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1392098818.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1392098818.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1392099724.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1392099724.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-20secondBorys.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-drone-sample.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-MVI_9117.mov-deeplearn.mkv.webm)
* [lines-small/lines-small-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-etude-1.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-etude-1.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-etude-1.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-lines.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-pulse.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [lines-small/lines-small-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [lines-small/lines-small-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [lines-small/lines-small-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/lines-small/lines-small-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1392098671.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1392098671.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1392098818.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1392098818.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1392099724.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1392099724.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-20secondBorys.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-drone-sample.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-MVI_9117.mov-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-lines.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-pulse.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [osborne-combined-big/osborne-combined-big-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/osborne-combined-big/osborne-combined-big-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1392098671.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1392098671.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1392098818.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1392098818.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1392099724.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1392099724.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-20secondBorys.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping.deeplearn.mov.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping.deeplearn.mov.webm)
* [ramshackletyping/ramshackletyping-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-drone-sample.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping.mov.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping.mov.webm)
* [ramshackletyping/ramshackletyping-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-MVI_9117.mov-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-etude-1.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-etude-1.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-etude-1.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-lines.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-pulse.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-ramshackletyping.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-ramshackletyping.mov-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [ramshackletyping/ramshackletyping-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/ramshackletyping/ramshackletyping-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1392098671.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1392098671.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1392098818.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1392098818.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1392099724.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1392099724.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-20secondBorys.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-drone-sample.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-MVI_9117.mov-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-1.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-1.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-1.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-lines.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-pulse.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-pulse.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-pulse.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-pulse.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-deeper/seeing-a-sound-deeper-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-015-loud_barking_and_guitar.1397370485.10527-out.15-loud_barking_and_guitar.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-114-tones.1397368837.20976-out.114-tones.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1392098671.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1392098671.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1392098671.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1392098671.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1392098818.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1392098818.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1392098818.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1392098818.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1392099724.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1392099724.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1392099724.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1392099724.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1408297309.27876-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1408297309.27876-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1408304868.8993-out.caffeine.wav.audio.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-1408304868.8993-out.caffeine.wav.audio.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-20secondBorys.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-20secondBorys.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-20secondBorys.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-20secondBorys.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-alphabet-conspiracy.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-alphabet-conspiracy.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-alphabet-conspiracy.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-belch-kitchen-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-belch-kitchen-sample.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-belch-kitchen-sample.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-Bimbo's_Initiation_1931.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-Bimbo's_Initiation_1931.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-drone-sample.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-drone-sample.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-drone-sample.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-drone-sample.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-govid3-oldsketch.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-govid3-oldsketch.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-govid3-oldsketch.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-MVI_9117.mov-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-MVI_9117.mov-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-1.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-1.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-1.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-1.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-2.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-2.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-2.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-etude-2.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-lines.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-lines.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-lines.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-lines.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-ode-to-jimmie.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-ode-to-jimmie.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-seeing-sound.mp4-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-seeing-sound.mp4-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-osborne-seeing-sound.mp4-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-seeing-a-sound-shallow-MVI_9117.mov-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-seeing-a-sound-shallow-MVI_9117.mov-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-spikey-mouth-loop.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-spikey-mouth-loop.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-spikey-mouth-loop.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130404_003435.mp4.1384674117.corpus.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130404_003435.mp4.1384674117.corpus.mkv-granular-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130531_132327.mp4.1384676233.corpus.mkv-deeplearn.mkv.webm)
* [seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm](https://archive.org/download/DeepLearningBitmaptoPCM/seeing-a-sound-shallow/seeing-a-sound-shallow-VID_20130531_132327.mp4.1384676233.corpus.mkv-granular-deeplearn.mkv.webm)
