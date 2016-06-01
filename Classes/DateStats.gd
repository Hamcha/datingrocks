extends BaseClass

var aroused    = 0
var awkward    = 0
var happy      = 0
var pissed     = 0
var interested = 0
var bored      = 0
var disgusted  = 0

func apply(delta):
	aroused    += delta.aroused
	awkward    += delta.awkward
	happy      += delta.happy
	pissed     += delta.pissed
	interested += delta.interested
	bored      += delta.bored
	disgusted  += delta.disgusted