Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSGYAXZ>; Wed, 24 Jul 2002 20:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSGYAXZ>; Wed, 24 Jul 2002 20:23:25 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:38660 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id <S318060AbSGYAXX>; Wed, 24 Jul 2002 20:23:23 -0400
Date: Thu, 25 Jul 2002 02:24:54 +0200
From: Daniel Mose <imcol@unicyclist.com>
To: linux-kernel@vger.kernel.org
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Message-ID: <20020725022454.A8711@unicyclist.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> I've been sitting on this question for years, hoping I'd come across the 
> answer, and I STILL don't know what the "i" is short for.  Somebody here has 
> got to know this. :)
> 
> I know what an inode IS (although it took me almost a year to figure this 
> out, way back when), but I don't know what the name means.
> 
> I've been following this list for years now, and nobody's ever actually said 
> what the i stands for, and neither do the (sparse) comments in fs/inode.c.  
> I've read Peter Salus's book "a Quarter Century of Unix".  I've read the 
> history of early unix development on Dennis Richie's home page, and although 
> it complains that his original notes came back form the dictation service 
> misspelling "inode" as "eyenode", it doesn't say what the I stands for.  I'm 
> only about a third of the way into "Life with Unix", but it doesn't seem like 
> a particularly technical history so far...

I have followed the LKML for only about 2 months. I have been 
thinking of posting something similar. ( just not 'bout i-nodes )

Someone pointed out earlier in this thread: 
"How Newbie can one get?" 
To my point of view this topic does not fall into the "Newbie" 
cathegory. Rather I would choose to call this 

a Linux kernel "Alienate" topic. 

Rob has actually made severe long time efforts to take on Unix, 
and just as I know I will, he has failed.
As I my self feel very alienated to some of the structural 
names in a Unix environment I actually applaud Rob for daring 
to start, and maintain this topic in here. ( Not that I find 
any of the guys in here to be either scary or unpleasant in 
any way. Just buzy doing some great ( but mysterious ) work )

I can easily cope with the Idea that the I in I-node stands for
whatever one likes it to be. The I-node context makes very good 
sense to me when you put it to work in FS context. The name 
I-node is as I see it, close to semantic rape. (as I also find 
some of the K&R/ANSI C keywords to be ) 

What bothers my self a bit more in the kernel context, and thus 
makes me an even more eager "Kernel alienate" than I believe Rob
to be, are the "atomic_" calls/functions and their semantic origin.
I believe that every Unix has "atomic_" calls all though perhaps 
differently designed. And I totally fail to understand why some 
one decided to name theese functions "atomic_"

To my own thinking, the atomical parts of any process in a 
computer are puny little switches that are mostly referred to as 
bits, and theese bits have all the software support they can get 
even with out any "atomic_" call. I don't find anything even 
remotely close to an electron microscope within Unix either.
So I fail. 

Perhaps you Rob can clear me out on this one though? I mean: 
You have actually managed to endure, being a kernel alienate 
for a much longer time than I can hope for my self.

Other words in this ML (and in too many other places =( ) that
make my own brain go rivetted and short circuit are the "foo" 
and/or "bar", not to mention the "foobar" place holder.
 
I realize that most folks In LKML use "foo", "bar" and it's dad,
"foobar" with outmost joy and that there is complete and utter 
understanding of what the "foos" and "bars" actually stand for 
in your contemporary discussion partners reasoning scheeme. 

Or is it? 

Some times I notice that people who write pseudo code find good 
replacer words which actually explain the place holders function 
context, where the average linux kernel posters simply puts their
"foo","bar" or "foobar" But I have yet Not noticed this horrificly
effective way of clarifying ones intentions anywhere in the postings
to the linux kernel mailing list. Therefore I conclude that you must
all be telepathic phenomenons, or that you have all found some other
odd or mysterious way of mentally tuning in the intentions of your 
contemporary discussion partners. 

This conclusion is primarily based upon that I'm actually success-
full in typing in, and saving this followup on a linux box, that 
boots up almost without any errors every single time I push the 
power button. 

This might not actually have to be the truth, however. 

Suppose that you do missunderstand your discussion partner frequently.

So you each type in some related patches and send them of to linus(?) 
linus (or whom-ever) sends them back, saying "half is buggy" So you're 
back discussing again. This time you have half the code bugfree so 
you only need to discuss the buggy half. You discuss it, missunder-
stand each others frequently again because of some "foos" and "bars" 
and thus send in another patch, which is refused as being 
"quarterly-buggy", and so on...

So which one is it?

> (Yes, I am breaking the internet convention of posting errors rather than 
> asking questions if you want people to respond.  I can come up with some 
> errors if you'd like.  I'm good at that. :)

Thank you very much for this topic, Rob. 

kind regards Daniel Mose.
