Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129536AbQKEDYE>; Sat, 4 Nov 2000 22:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKEDXz>; Sat, 4 Nov 2000 22:23:55 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:775 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129536AbQKEDXq>; Sat, 4 Nov 2000 22:23:46 -0500
Date: Sat, 4 Nov 2000 22:28:35 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001104222835.A27549@munchkin.spectacle-pond.org>
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> <200011020011.QAA20585@pizda.ninka.net> <8tqcng$d8p$1@cesium.transmeta.com> <3A01B8BB.A17FE178@Rikers.org> <20001102212124.A15054@gruyere.muc.suse.de> <7pChupdXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <7pChupdXw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Sat, Nov 04, 2000 at 02:24:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 02:24:00PM +0200, Kai Henningsen wrote:
> ak@suse.de (Andi Kleen)  wrote on 02.11.00 in <20001102212124.A15054@gruyere.muc.suse.de>:
> 
> > again with a different syntax than gcc [I guess it would have been too easy
> > to just use the gcc syntax]
> 
> One of the big problems in C99 was that there was nobody on the committee  
> who really understood gcc well, so the committee had problems using gcc  
> solutions given that nobody would be able to really describe them.

Or the GCC syntax was too limited to do all of what the committee wanted.

> And the reason no such expert was there was that the FSF didn't send  
> anyone, because they seem to think standards tend to ignore what they want  
> to do.

Actually, RMS had quite a lot of influence on the original standard, even
though he didn't attend the meetings.  His replies to the public comment period
were fairly long and real insightful.  Even if some of his issues were voted
down, they were discussed over quite a few meetings.

I was on the original ANSI C committee from its founding, through the C89
standard, and for a year or two afterwards as the initial changes for C99 were
discussed, for a total of 10 1/2 years (representing first Data General, then
for OSF, though the early Data General years were before I switched over to
GCC).  Towards the end, I was rather burned out by the process, and didn't push
too hard at Cygnus to go to the meetings, and nobody seemed willing to step in
(at the time Cygnus only had 4 GCC engineers, and like now there was always
more GCC work to do than bodies to do work).  The trouble is it takes a lot of
time from your paying job to actively participate (figure 4 week long meetings
a year, plus the time to read documents, wordsmith, etc.).

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
