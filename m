Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbRLYIKo>; Tue, 25 Dec 2001 03:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285426AbRLYIKe>; Tue, 25 Dec 2001 03:10:34 -0500
Received: from www.wen-online.de ([212.223.88.39]:26128 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S285424AbRLYIKb>;
	Tue, 25 Dec 2001 03:10:31 -0500
Date: Tue, 25 Dec 2001 09:09:31 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Maybe I have a bad day or something
In-Reply-To: <01122415075100.02141@manta>
Message-ID: <Pine.LNX.4.33.0112250745190.631-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001, vda wrote:

> Hi all,
>
> I'd like to share with all subscribers my experience with my first year on
> this list.
>
> Posting questions here is fruitless. They are offtopic by definition.

Your attitude sucks rocks.

> Who fscking care that I am trying to debug a kernel problem and my first
> ksymoops compilation went astray? (I discovered that ksymoops needs bfd lib
> from binutils a month later). We need no stinking decoded oops!
> And we never were newbies, we were born with Linux in our blood!
>
> Well, maybe the list is useful for bug reports? Maybe, here is an example:
> >> BTW, don't go for 2.4.x, x>10. initrd is broken there and is still unfixed.
> >Bullshit.
> I've done a damn good investigation on that, I compiled over a dozen kernels
> for that, I *know* where is the bug, I don't just moaning! Response: either
> deafening silence or this "warm and encouraging" reply. We need no stinking
> details of your problems.

Excuse me?  I took the time to build/boot a minix initrd for which I
had absolutely no use, just to verify your problem.  That led to you
discovering that having cramfs configured in for some reason mucks up
your minix initrd load.  Someone else discovered a corruption problem,
and some heavy-weight talent fixed it instantly.

Seems to me that your problem is resolved.. unless you really _need_
the cramfs and minix initrd combo.  If that's the case, I suggest you
either grab kdb and do some work, or submit a polite bug report to the
cramfs maintainer and be prepared to wait patiently.

CRAMFS FILESYSTEM
P: Daniel Quinlan
M: quinlan@transmeta.com
W: http://sourceforge.net/projects/cramfs/
S: Maintained

> You may think that this list is for patches. Well, partly.
> Patches submitted here are ignored 50% of times. What's the use in explaining
> to poster why patch is bad and how to improve it? He's expected to read minds
> from distance. Or maybe we need no stinking new hackers, old boys are enough?
>
> What this list is good for? I'll tell ya:
>
> a) for discussions about proper name and abbreviation of kilobyte.
>    Oh, now I know how many _true _coders_ are there!
>    Just count that "KB/KiB" subj line in your lkml mail folder.
>
> b) for telling patch authors that their patch should NOT be applied.
>    ("Why we should turn off those bits in VIA chipset? They're documented
>    as 'debug, dont touch'". Who cares that with those bits set to 1
>    Athlons are oopsing like crazy.) It's so much easier to flame
>    that to _make_ patches, isn't it?

Take close look at the above and imagine how many people on this list
may now think you're an obnoxious son-of-a-bitch not worth speaking to.

> Ok, enough. Steam pressure is much lower now :-)

Enough indeed.

> I wish in 2002 lkml signal/noise ratio to be much higher.
> How about putting that in standard lkml sig:
>
> -To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> -the body of a message to majordomo@vger.kernel.org
> -More majordomo info at  http://vger.kernel.org/majordomo-info.html
> +Please make sure your posting is *useful* for linux kernel development
> +To unsubscribe: read  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

This post was useful?!?

> OTOH, I must say that there are quite some good people there
> I want to say "Thank you! Great coding!" to:
>
> Linus, Alan Cox, Marcelo Tosatti (kernel maintenance)
>   (what about bug/patch tracking system, leaders?
>   it's sad to see good patches dropped and longstanding
>   bugs unaddressed)
> Andrea Arcangeli (VM)
> Robert Love (preemption)
> Richard Gooch (devfs)
> Trond Myklebust (nfs)
> Al Viro (fs)
>   (but could you _please_ be less agressive Al? Your comments are useful,
>   but your emotions are always negative! What we have done to you?)

How very decent of you to hand out accolades with attached derision.

> I don't remember all of you, definitely this list must be longer...
>
> Happy New Year to everyone.
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

