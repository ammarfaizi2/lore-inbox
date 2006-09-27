Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWI0RBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWI0RBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWI0RBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:01:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030250AbWI0RAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:00:34 -0400
Date: Wed, 27 Sep 2006 10:00:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0609270947030.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <1159319508.16507.15.camel@sipan.sipan.org> <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Jan Engelhardt wrote:
> 
> If by operating system you mean the surrounding userland application, 
> then yes, why should there be a problem with a GPL2 kernel and a GPL3 
> userland? After all, the userland is not only GPL, but also BSD and 
> other stuff.

Indeed.

We have no trouble at all running programs with much worse licenses than 
the GPLv3 (ie commercial programs). There is no problem with user space 
being v3.

> >The last Q. is how good is the almost forgotten Hurd kernel?
> 
> Wild guess: At most on par with Minix.

...and here's a thing that most people forget: good code simply doesn't 
care about ideology, and ideology often does the wrong technical decisions 
because it's not about practical issues.

The watch-word in Linux development has been "pragmatism". That's probably 
part of what drives the FSF wild about Linux in the first place. I care 
about _practical_ issues, not about wild goose chases.

If I weren't into computers, I'd be in science. And the rules in science 
are the same: you simply can't do good science if you start with an 
agenda. If you say that you'll never touch high-energy physics because 
you find the atom bomb to be morally reprehensible, that's your right, but 
you have to also realize that then you can never actually understand the 
world, and do everything you may need to do.

I've often compared Open Source development vs proprietary development to 
science vs witchcraft (or alchemy).

In many ways, the GPLv3 is about "religion". They limit the technology 
because they are afraid of it. It's not that different from a religious 
standpoint that some research is "bad" - because it undermines the 
religious beliefs of the people. You'll find extremists in the US saying 
that things like evolution is an affront to very basic human morals, the 
exact same way that rms talks about DRM being "evil".

I want to be a "scientist". I want people to be able to repeat the 
experiments, logic, and measurements (that's very much what science is 
about - you don't just trust people saying that the world works some way), 
but being a scientist doesn't mean that you should let other scientists 
into your own laboratory or into your own home. That would be just crazy 
talk.

So as a "scientist", I describe in sufficient detail my theory and the 
results, so that anybody else in the world can replicate them. But they 
can replicate them in their _own_ laboratories, thank you very much.

That's what open source is all about. It's about _scientific_ ideals. 
It's not on a moral crusade, and it never has been. 

The point behind all this: even if the Hurd didn't depend on Linux code 
(and as far as I know, it does, but since I think they have their design 
heads firmly up their *sses anyway with that whole microkernel thing, I've 
never felt it was worth my time even looking at their code), I don't 
believe a religiously motivated development community can ever generate as 
good code except by pure chance.

				Linus
