Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129580AbRBQTQC>; Sat, 17 Feb 2001 14:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130239AbRBQTPw>; Sat, 17 Feb 2001 14:15:52 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:48399 "EHLO
	babsi.intermeta.de") by vger.kernel.org with ESMTP
	id <S129580AbRBQTPk>; Sat, 17 Feb 2001 14:15:40 -0500
Date: Sat, 17 Feb 2001 20:15:39 +0100
From: "Henning P . Schmiedehausen" <hps@intermeta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
Message-ID: <20010217201539.B13970@forge.intermeta.de>
Reply-To: hps@intermeta.de
In-Reply-To: <96lrau$dcd$1@forge.intermeta.de> <200102171337.f1HDbwh13232@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102171337.f1HDbwh13232@flint.arm.linux.org.uk>; from "Russell King" on Sat, Feb 17, 2001 at 01:37:58PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 01:37:58PM +0000, Russell King wrote:

> Henning P. Schmiedehausen writes:
> > But at least I would be happy if there would be a printing
> > engine that is entirely open source and all the printer vendors can
> > write a small, closed source stub that drives their printer over
> > parallel port, ethernet or USB and give us all the features, that the
> > Linux _USERS_ (and these are the people that count) want.
> 
> Speaking as a Linux _USER_, if this happens, can I get said print
> engine working on my ARM machines with these closed source drivers?
>
> Can Alpha users get this print system working?  Can Sparc uses
> get it working?  What?  I can't?  They can't?  Well, its no good to
> me nor them.  

Maybe not. But you can use this print engine API to pay anyone to
write a driver for you. What you just said, is exactly my point. You
said:

"If a company does not write a driver which works on all hardware
 platforms in all cases and gives us the source, then it is better,
 that the company writes no drivers at all."

"If I can't force a company to write a driver for everyone, then I
 don't want to write them any driver at all."

IMHO you're like a spoiled kid: "If I can't have it, noone should have it".

> You've just made the system x86 specific.  Well done, thats a step
> backwards, not forwards.

No. Some Linux users got a driver that works as well as the drivers
for another OS. This is good for Linux. And all Linux users and
developers got an open, stable API, which is supported by big printer
vendors and enables everyone to write good drivers.

If you need a printer driver for the ARM, you're able to approach the
company XXX and either pay for an ARM specific driver (and they will
listen to you because they already have made a driver for another
Linux platform, learned that they can make money with Linux software
and have experience with driver(s) for Linux. And it will be just a
recompile most of the time).

> Ah, golly, I'll just have to throw my ARM machines away because
> we have some critical parts of the system which are closed source.

We're talking about a driver. If Company XX won't sell it to you for
your architecture, it's their right to do so. There is software that
I've written that you might want to have, too. If I chose not to sell
it to you, what do you do? You can say "company XX sucks" and buy an
equal product with an ARM driver from YY which listens to you. _THAT_
is IMHO open. Not forcing everyone to comply with your ideology.

> > But even if there is such an engine written for Gnome or KDE, some
> > really ingenious "free software advocate" will slap a "must not be
> > used with any kind of non-GPL driver" on it...
> 
> Good.  I build the stuff to work on my ARM machines.

Can you get a Legato Networker Client for Linux-ARM? Can you get one for
Linux-MIPS? Why? Because someone payed for the port.

> They don't work on ARM though, do they?  Gee, I guess ARM Ltd ought to
> stop my contract because what use is an ARM kernel without everything
> else to go with it?
> 
> For me, closed source is _REALLY_ bad news.  _EXTREMELY_ bad news.
> It 100% prevents me from doing stuff.

No. It means, that for some programs, in order to have them, you have
to pay. That is fine. There ain't no such thing as a free lunch. You
may, of course, chose not to pay, but then you may not be able to use
a certain program.

Look, I'm willing to pay money for the whole M$ Office Suite on
Linux. Yes.  I would give billg gladly a big chunk of my money to get
this application suite on Linux. Not a copy or a "just almost like M$
Office". But the real thing. The real "M$ Office 2k" suite for Linux.

Can I?  No. Because M$ chose not to offer its product for Linux. Bad
for me. It means, that I can not get parts of my work done on Linux.
Can I buy AutoCAD? Photoshop? Quicken? Outlook? Visio? Not look alikes
or clones or "almost as good as". But the real thing with the same
support as on Windows. I can for the Mac. Why can't I for Linux?

Because IMHO some companies shy away from the aggressive and sometime
openly hostile behaviour of the Open Source community ("If you don't
support your application on Linux/SPARC with an B/W framebuffer, you
suck. Go away") towards commercial companies.  ("If you don't support
Gnome 1.0 but just KDE 2.1, you suck. Go away"). And billg laughs and
just points the confused companies towards the "stable" and "easy to
use" M$ OS.

And the volatile APIs which are immature in some points (Font handling. 
Printer support. Color handling. Same things all the time. But displaying 
the results of your work and printing them onto paper is for many
people the most important thing. And frankly, Linux sucks here).

In your opinion, it is better, that I can't get some programs at all
than paying money for them.

In my opinion, I prefer to get it at least for i386/Linux than not to
get them at all. Because if I can't get them for i386/Linux, I must
get them for i386/Windows. Because I need a specific application. 
Not a specific OS architecture.

> Its really good that the Linux community is so open.

So tolerate the fact that some companies chose to release a program as
closed source for only one Linux platform. It is better than not
releasing at all.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
