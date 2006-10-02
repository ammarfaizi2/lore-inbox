Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWJBIt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWJBIt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 04:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWJBIt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 04:49:58 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:59284 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750858AbWJBIt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 04:49:57 -0400
Message-ID: <4520D1E9.6000509@aitel.hist.no>
Date: Mon, 02 Oct 2006 10:46:33 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Neil Brown <neilb@suse.de>, Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>  <451798FA.8000004@rebelhomicide.demon.nl>  <17687.46268.156413.352299@cse.unsw.edu.au>  <1159183895.11049.56.camel@localhost.localdomain> <1159200620.9326.447.camel@localhost.localdomain> <451CF22D.4030405@aitel.hist.no> <Pine.LNX.4.64.0609290940480.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609290940480.3952@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 29 Sep 2006, Helge Hafting wrote:
>   
>>   
>> This seems silly to me.  Sure, lasers and medical equipment is
>> dangerous if used wrong.  When such equipment is
>> controlled by software, then changing that software brings
>> huge responsibility.  But it shouldn't be made impossible.
>>     
>
> It may be "silly", but hey, it's often a law. 
>   
The manufacturer is liable for damages if the product is
dangerous as-is.  If you modify the product in ways the documentation
says you shouldn't, then it isn't their product anymore.  It
is _your_ product then, and now you are the one responsible
for damages.

A law against software modification just move the discussion
to "for or against" that law.
> Also, even if it wasn't about laws, there is a very valid argument that 
> you should be able to be silly. There's a reason people don't get locked 
> up in prisons just for being silly or crazy - sometimes something that 
> seems silly may turn out to be a great idea. 
>
> And people seem to totally ignore that there is no correct answer to "who 
> may do software updates?". People rant and rave about companies that stop 
> _you_ from making software updates, but then they ignore the fact that 
> this also stops truly bad people from doing it behind your back.
>   
And how would truly bad people modify any of my software?

My car engine may explode if programmed with sufficiently
stupid ignition timing and/or turbo mismanagement.
Nothing prevent upgrades though, there are companies
selling "chip upgrades" and so on.  Now, this isn't open source, but
the information isn't that hard to get either. Still, we don't see
abuses.  Just chip upgrades, that often voids the warranty.

The car is secured by a lock - to which I have a key. That's all
the security I need.  My home devices mostly require precence
to be reprogrammed, so no bad guys without my house keys.
The PC is an exception of course.
> Quite frankly, in many situations, I'd sure as hell be sure that any 
> random person with physical access to a machine (even if it was mine, and 
> even if I'm _one_ of them) could not just upgrade a piece of software.
>   
I want to be silly and reprogram something.  I should be able
to be silly, but not be able to do this reprogramming?
> Sometimes you can make those protections yourself (ie you add passwords, 
> and lock down the hardware - think of any University student computer 
> center or a library or something), but what a lot of people seem to 
> totally ignore is that often it's a hell of a lot more convenient for 
> _everybody_ if the vendor just does it.
>   

Vendor upgrades are convenient, sure.  That is not a reason for
limiting us to vendor upgrades _only._
> And no, the answer is not "just give the password to people who buy the 
> hardware". That requires individualized passwords, probably on a 
> per-machine basis. That's often simply not _practical_, or is just much 
>   
A jumper needed for reprogramming limits reprogramming to
someone who is physically present - i.e. the owner. Problem
solved without passwords.
> more expensive. It's quite natural for a vendor in this kind of situation 
> to just have one very secret private key per model or something like that.
>   
History have showed, again and again, that such a "very secret"
key will be broken, and that only have to be done once. Therefore,
people run linux on gaming boxes that was supposed to be locked
down.  And we can watch DVDs on linux too.
> In other words, these secret keys that people rant against JUST MAKE 
> SENSE. Trying to outlaw the technology is idiotic, and shortsighted.
>   
Yes "very secret" keys makes sense.  They are so useful, because
someone nice will disassemble an upgrade and then publish the
key.  Then the hobbyists can do what they want, while the
companies flasely believes they get what they want too. :-)

Still, it'd be better if they didn't bother. Just add a sticker with
"reprogramming voids the warranty and might kill you." and
be done with it.
> If you don't want a machine that is locked down, just don't buy it. It's 
> that simple. But don't try to take the right away from others to buy that 
> kind of convenience.
>   
Seems to me that this "convenience" is only for monopolists trying
to limit the usefulness of the device?  Sure, I can refrain from buying
some device, except that they don't usually document this kind
of limitation until you suddenly runs into it.

And of course this works the other way too.
People may write software that explicitly forbids locking down. If 
device manufacturers don't like that, they are free to not use the code. And
it is sometimes fun when they don't discover this until they have
shipped the devices and gets forced to supply a key. ;-)

> And yes, Tivo is exactly such a situation. It's damn convenient. I've got 
> two Tivo's myself (and yes - I actually paid full price for them. I was 
> given one of the original ones, but that's long since scrapped, and even 
> that one I paid the subscription fee myself). But you don't have to buy 
> them. You can build your own at any time, and it will probably be more 
> powerful.
>
> So people are trying to claim that something is "wrong", even though it 
> clearly is. The people arguing for "freedom" are totally ignoring my 
> freedom to buy stuff that is convenient, and ignore real concerns where 
> things like TPM etc actually can make a lot of sense.
>
> Can it be used for bad things? Sure. Knives are dangerous too, but that 
> doesn't make them "wrong" or something you shouldn't allow.
>   
What is the convenience of a locked-down device?  I agree it is nice
if the manufacturer can upgrade it - a convenience for any device
I won't bother with myself.  But why should that prevent _me_ from
reprogramming my device in a different way?  I see no need for
that at all. You can have one _and_ the other.

Helge Hafting


