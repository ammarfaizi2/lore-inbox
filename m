Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSKTEGM>; Tue, 19 Nov 2002 23:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSKTEGM>; Tue, 19 Nov 2002 23:06:12 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64516
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265711AbSKTEGK>; Tue, 19 Nov 2002 23:06:10 -0500
Date: Tue, 19 Nov 2002 20:12:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Some like it HOT! (Re: spinlocks, the GPL, and binary-only modules)
In-Reply-To: <Pine.LNX.4.44L.0211192349460.4103-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.10.10211191908440.1342-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Rik van Riel wrote:

> On Tue, 19 Nov 2002, Jeff Garzik wrote:
> 
> > So, since spinlocks and semaphores are (a) inline and #included into
> > your code, and (b) required for just about sane interoperation with Linux...
> >
> > does this mean that all binary-only modules that #include kernel code
> > such as spinlocks are violating the GPL?
> 
> > But who knows if #include'd code constitutes a derived work :(
> 
> Only if the #included snippets of code are large enough to be
> protected by copyright, which might be true of the stuff in
> mm_inline.h and of some of the semaphore code, but probably
> isn't true of the spinlock code.
> 
> Even if the code #included is large enough to be protected by
> copyright I don't know if the code including it would be considered
> a derived work. Many questions remaining...

Lets see, who to sue first?

The embedded people?  The video card people?  The people who ship binary
drivers?  All the people who sell appliances?  Oh please sue me, because I
license binary only drivers for various appliances.  This is a the
beginning of era of IP vultures and will quickly kill the use of Linux.

Free software does not make a dime with out value add.

So now that all the distros have their patch bomb hell that is not adopted
in the main stream, and some you can not download period.  Sure they "open
source" the patches.  Sure some have been caught putting in patches to
allow known binary extentions.  Then there was MOSIX in the past.

What the hell happened to Linux being a flexable tool, it is just a
kernel!

Well I am the two face bard(1) running around with a band of people force
others to open spec for the creation of open source.  Gee, some people
have contributed a lot and others less and remainder zero.  I guess it is
time to start the corporate litigation party raiders and become no better
than whom we all look down upon.  Oh HAIL Redmond we are soon to follow
your path to success and failure.

Somebody please tell me where I can invoice all the users of IDE/ATA/SATA
in the world of Linux.  Since I have about $30K in bills I paid myself to
attend meeting, stop CPRM/DMCA from openly screwing the hardware, sign
licensing agreements currently with more $25K outstanding to be
potentially collected, single handedly bring most of the chipset hardware
vendors to the table of OPEN SOURCE yet I suffer the legal binds of the
NDA's to bring you free drivers.

So the minute somebody wants to make a little money for the return to keep
them in a position to continue to offer you open source, the IP VULTURES
are out in full force to steal and taint quality closed IP for using just
the stinking headers?  Well I will be looking at using another OS which is
more business friendly now, because even though I would follow the rules
of forcable making my commerial product incapable of being compiled into
the kernel, there will be some "PISS ANT LOSER" ready to SUE me for just
using the headers. NICE !

Oh please bring it one, I have found my blow torch, flame thrower, and to
hell with the asbestos suit!!  It is winter time and lets make it HOT!

Yippe KIA-AHHY Mother F***** !


Andre Hedrick
LAD Storage Consulting Group

(1) bard, a story teller

