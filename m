Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVAKM>; Wed, 21 Feb 2001 19:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBVAKD>; Wed, 21 Feb 2001 19:10:03 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:4283 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S129170AbRBVAJy>;
	Wed, 21 Feb 2001 19:09:54 -0500
Message-Id: <l0313035fb6ba002f9000@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0102211454440.31651-100000@sol.compendium-tech.com>
In-Reply-To: <20010217110513.E10172@ldh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 22 Feb 2001 00:09:01 +0000
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        Augustin Vidovic <vido@ldh.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Linux stifles innovation...
Cc: Dennis <dennis@etinc.com>, jesse@cats-chateau.net, A.J.Scott@casdn.neu.edu,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:00 pm +0000 21/2/2001, Dr. Kelsey Hudson wrote:
>On Sat, 17 Feb 2001, Augustin Vidovic wrote:
>
>> 1- GPL code is the opposite of crap
>
>By saying this, you are implying that all pieces of code released under
>the GPL are 'good' pieces of code. I can give you several examples of code
>where this is not the case; several I have written for my own use, as a
>matter of fact.
>
>Software is only as 'good' as the effort the programmer who wrote it put
>into it. Spend an hour writing a device driver while watching TV, eating
>food, and after a couple dozen beers, and release it under the GPL. Is it
>good code? probably not. :p
>
>This isn't, however, to say that I think commercial code is better than
>GPL code... They both have their merits and deficiencies, so I value both
>equally based upon this (although all software *should* be free...)

I was going to stay out of this after a few days back, but I'll put in one
last point in favour of this:

I have seen good commercial software and extremely bad GPL software.  Here
are some examples:

Good commercialware:
- CorelXARA, by Computer Concepts, which totally blew CorelDRAW out of the
water on release (but then Corel failed to market it and instead nabbed all
the good ideas, tsk tsk)
- the assembler/programmer/emulator for my Motorola 68HC08 microcontroller

Both of these were developed by relatively small companies which don't have
to kowtow to shareholders every 5 minutes.

Terrible GPLware:
- VNC Server for Macintosh, AT&T version 3.3.2 (I tried to debug this and
eventually gave up and rewrote it from scratch)
- Some architectures' ports of the Linux kernel, at least in their current
state (has anyone actually tried to *compile* the PPC kernel since
2.4.<whatever> besides me?)

In the former case, I was able to take the few useful pieces of code and
re-use them in the replacement - which I was *paid* to write, but is still
GPL'ed in the spirit of the VNC project.  In the latter case, people can
see and experience the problem, and get on with fixing it as and when they
need to and/or get time to.  This is somewhat different in nature to, say,
WinNT which dumped the Alpha platform overnight...

I'll shut up now, especially as this isn't exactly the right place for this
discussion...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


