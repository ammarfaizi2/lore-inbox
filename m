Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSKYTxS>; Mon, 25 Nov 2002 14:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSKYTxS>; Mon, 25 Nov 2002 14:53:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265589AbSKYTxQ>; Mon, 25 Nov 2002 14:53:16 -0500
Date: Mon, 25 Nov 2002 15:00:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dennis Grant <trog@wincom.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
In-Reply-To: <3de27d7d.59a8.0@wincom.net>
Message-ID: <Pine.LNX.3.95.1021125144007.806A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Dennis Grant wrote:

> >Richard B. Johnson wrote:
> 
> >> This is the linux-kernel list. Nothing you said has anything
> >> to do with the linux-kernel. 
> 
> Oh really Richard?
> 

Well, if you are going to reply to me, you really should c.c. me.
I am beginning to understand that you are really just a troll looking
for trouble. However I will, again try to be nice and show you the
errors of your ways.

> Re-read the message. 
> 

I have read the message.

Of course, you didn't bother to fix your mailer as advised so you
didn't read my message either.

> Point #1 has to do with kernel configuration; ie, "cd /usr/src/linux ; make
> xconfig" and the choices made thereafter. I want something like "make modelnu
<added wrap > mberconfig"
> that abstracts away most of the lower level items based on what low-level
<added wrap> stuff
> is associated with which chunk of hardware.*

Now, let me get this straight; "I want something that abstracts away most
of the low-level items...." Damn! I want a Learjet!  As I said, if you
want one, you make one and, as I stated before it isn't as easy as you
seem to think and I think you have proven that you are not too well
learned about kernel modules and configuration items when you want to.
I quote; "abstract away most of the lower level items..." 

> 
> I'm pretty sure any time you're invoking the kernel Makefile that you're
<added wrap> discussing
> a "linux kernel issue"
> 

No. You are discussing a personal preference. Like I said, if you don't
like it, you make a new one. It's just that simple. Once you start
looking into what it takes to configure a kernel, if you have any
smarts at all, you will have some second thoughts about this.

> Point #2 has to do with the messages that drivers, modules, and other bits
<added wrap> of
> kernel code print to the dmesg data store wrt how they are currently set up
> - in other words, kernel state information. The last time I checked, these
<added wrap> messages

Drivers write the messages that the driver authors wanted them to write.
The kernel "state" at that time was that the driver was called. If you
have a problem with a specific driver message, you contact the author
and suggest something. The kernel only writes the messages that some
module author wanted. It tries to get the message out, even if the
kernel is very sick.

> were contained inside the kernel source - I remember looking through "ide.c"
> looking to see what the "idebus=xx" parameter really controlled, and if it had
> anything to do with the ATAxx values (as it turns out, it does not, although
> my Googling indicates that this seems to be a common misconception)
> 
> So this, as well, is entirely appropriate material for linux-kernel.
> 
> Point #3 has to do with the issues in publishing where what hardware is 
<added wrap> supported
> in what kernel version, and where drivers not currently contained in the
<added wrap> vanilla
> kernel are located. Put another way, point #3 is about locating the output of
> the work of people "employed" on linux-kernel, and so is also entirely
<added wrap> appropriate.
> 
> 
> That you are knee-jerk flaming a legitimate message that is entirely on-topic
> indicates that you didn't actually read the message, and instead fixated on
> one or two statements contained within itand made assumptions from there. That
> doesn't seem like good kernel developer practice - perhaps you were looking
> for Slashdot?

You got no knee-jerk flaming from me. If you think you did, you are in a
world of hurt.

[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


