Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRF0N2E>; Wed, 27 Jun 2001 09:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261198AbRF0N1z>; Wed, 27 Jun 2001 09:27:55 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:59717 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261274AbRF0N1p>; Wed, 27 Jun 2001 09:27:45 -0400
Date: Wed, 27 Jun 2001 08:26:55 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106271326.IAA03158@tomcat.admin.navo.hpc.mil>
To: landley@webofficenow.com, <asmith@14inverleith.freeserve.co.uk>,
        Kai Henningsen <kaih@khms.westfalen.de>
Subject: Re: [comphist] Re: Microsoft and Xenix.
In-Reply-To: <01062610445301.12583@localhost.localdomain>
Cc: <linux-kernel@vger.kernel.org>, <penguicon-comphist@lists.sourceforge.net>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@webofficenow.com>:
> On Monday 25 June 2001 16:19, asmith@14inverleith.freeserve.co.uk wrote:
...
> > I learnt my computing on a PDP8/E with papertape punch/reader, RALF,
> > Fortran II, then later 2.4Mb removable cartridges (RK05 I think).  toggling
> > in the bootstrap improved your concentration. Much later you could
> > get a single chip(?) version of this in a wee knee sized box.
> 
> "A quarter century of unix" mentions RK05 cartridges several times, but never 
> says much ABOUT them.
> 
> Okay, so they're 2.4 megabyte removable cartridges?  How big?  Are they tapes 
> or disk packs?  (I.E. can you run off of them or are they just storage?)  I 
> know lots of early copies of unix were sent out from Bell Labs on RK05 
> cartidges signed "love, ken"...

Ah, the memories... (apologies for the interruptions, but just had too ...)

RK05 cartriges looked very similar to a floppy case the size of an old 78 RPM
record (about 12 inches across, 2 - 3 inches high). I never used them, but
I did see them. They were among the first disk drives DEC ever made. Not the
first (I think that was a DF-32 for PDP 8 systems with 32 K bytes of disk
space). The raw storage was reported as 2.5 MB, formatted was ~2.4MB, with
two recording surfaces. The drive looked very similar to a modern CD drive
that would fit in about a 3U (ummm 4U?) 19 inch rack. It had 2 recording
surfaces. It did have a write enable/disable switch. If I remember right
these were originally made for the PDP 11/10-20 systems used for laboratory
device control - chromatographs were mentioned by the chemistry department
back in school.

I may have an old DEC peripheral specification book at home (11/45 version).
I really liked those books that DEC used to put out. If you ever needed to
program a DEC interface, that book had everything. It was almost like the
engineers were bragging about how easy the interfaces were to program.

> What was that big reel to reel tape they always show in movies, anyway?

I think they were CDC transports.

> I need a weekend just to collate stuff...
> 
> > One summer job was working on a PDP15 analog computer alongside an 11/20
> > with DECTAPE, trying to compute missile firing angles. [A simple version of
> > Pres Bush's starwars shield].
> 
> Considering that the Mark I was designed to compute tables of artillery 
> firing angles during World War II...  It's a distinct trend, innit?  And the 
> source of the game "artillery duel", of course...

Or the 11/34 version of the Lunar Lander (load from paper tape, graphics
display on VT11 - 512x512 8 bit color). It used to be distributed as a
diagnostic tool (hardware level interrupts, dual A/D conversion via joystick,
I/O via VT11). Any memory, DMA, or bus configuration errors would hang
the system with a known diagnostic one-liner message explaining the problem.

I also saw a report of a "terminal warfare" event where the graphics display
was being used for text editing when two little stick figure men would walk
onto the display, pick up a line, and then walk off the screen. There was
nothing the user could do until it finished. The text buffer wasn't touched,
only the display buffer.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
