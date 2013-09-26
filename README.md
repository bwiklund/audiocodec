audiocodec
==========

### Usage

First, you'll need some audio converted to 32 bit floating point, which is easy with `sox`

```
sox mysong.mp3 -c 1 -e floating-point --bits 32 -V out.raw
```

Then run the crappy audio codec demo.

```
coffee demo.coffee -f raw
```

### How it works

It turns the audio stream into chunks, calculates the DCT (discrete cosine transform) on them, strips the higher frequencies, and then rebuilds the audio (very lossily)

Don't use this for anything, it's slow and the results aren't great. It's just an experiment with some math I'd like to learn more about.