Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbWI2QwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWI2QwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWI2QwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:52:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161265AbWI2QwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:52:02 -0400
Date: Fri, 29 Sep 2006 09:51:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Neil Brown <neilb@suse.de>, Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <451CF22D.4030405@aitel.hist.no>
Message-ID: <Pine.LNX.4.64.0609290940480.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <451798FA.8000004@rebelhomicide.demon.nl>  <17687.46268.156413.352299@cse.unsw.edu.au>
  <1159183895.11049.56.camel@localhost.localdomain>
 <1159200620.9326.447.camel@localhost.localdomain> <451CF22D.4030405@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2006, Helge Hafting wrote:
>   
> This seems silly to me.  Sure, lasers and medical equipment is
> dangerous if used wrong.  When such equipment is
> controlled by software, then changing that software brings
> huge responsibility.  But it shouldn't be made impossible.

It may be "silly", but hey, it's often a law. 

Also, even if it wasn't about laws, there is a very valid argument that 
you should be able to be silly. There's a reason people don't get locked 
up in prisons just for being silly or crazy - sometimes something that 
seems silly may turn out to be a great idea. 

And people seem to totally ignore that there is no correct answer to "who 
may do software updates?". People rant and rave about companies that stop 
_you_ from making software updates, but then they ignore the fact that 
this also stops truly bad people from doing it behind your back.

Quite frankly, in many situations, I'd sure as hell be sure that any 
random person with physical access to a machine (even if it was mine, and 
even if I'm _one_ of them) could not just upgrade a piece of software.

Sometimes you can make those protections yourself (ie you add passwords, 
and lock down the hardware - think of any University student computer 
center or a library or something), but what a lot of people seem to 
totally ignore is that often it's a hell of a lot more convenient for 
_everybody_ if the vendor just does it.

And no, the answer is not "just give the password to people who buy the 
hardware". That requires individualized passwords, probably on a 
per-machine basis. That's often simply not _practical_, or is just much 
more expensive. It's quite natural for a vendor in this kind of situation 
to just have one very secret private key per model or something like that.

In other words, these secret keys that people rant against JUST MAKE 
SENSE. Trying to outlaw the technology is idiotic, and shortsighted.

If you don't want a machine that is locked down, just don't buy it. It's 
that simple. But don't try to take the right away from others to buy that 
kind of convenience.

And yes, Tivo is exactly such a situation. It's damn convenient. I've got 
two Tivo's myself (and yes - I actually paid full price for them. I was 
given one of the original ones, but that's long since scrapped, and even 
that one I paid the subscription fee myself). But you don't have to buy 
them. You can build your own at any time, and it will probably be more 
powerful.

So people are trying to claim that something is "wrong", even though it 
clearly is. The people arguing for "freedom" are totally ignoring my 
freedom to buy stuff that is convenient, and ignore real concerns where 
things like TPM etc actually can make a lot of sense.

Can it be used for bad things? Sure. Knives are dangerous too, but that 
doesn't make them "wrong" or something you shouldn't allow.

			Linus
