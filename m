Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282792AbRLBGeU>; Sun, 2 Dec 2001 01:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282786AbRLBGeL>; Sun, 2 Dec 2001 01:34:11 -0500
Received: from four.malevolentminds.com ([216.177.76.238]:10245 "EHLO
	four.malevolentminds.com") by vger.kernel.org with ESMTP
	id <S282783AbRLBGeG>; Sun, 2 Dec 2001 01:34:06 -0500
Date: Sun, 2 Dec 2001 06:34:17 +0000 (GMT)
From: Khyron <khyron@khyron.com>
To: LKML - Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
Message-ID: <Pine.BSF.4.33.0112020626460.94365-100000@four.malevolentminds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to:

> "it works/does not work for me" is not testing. Testing
> is _actively_ trying to break things, _very_ preferably
> by another person that wrote the code and to do it
> in documentable and reproducible way. I don't see many
> people doing it.

from "Stanislav Meduna <stano@meduna.org>", Alan Cox said:

"If you want a high quality, tested supported kernel which
has been through extensive QA then use kernel for a
reputable vendor, or do the QA work yourself or with other
people. We have kernel janitors, so why not kernel QA
projects ?

"However you'll need a lot of time, a lot of hardware and
a lot of attention to procedure"

But in his earlier e-mail, Stanislav Meduna said:

"Evolution does not have the option to vote with its feet.
The people do. While Linux is not much more stable than it
was and goes through a painful stabilization cycle on every
major release, Windows does go up with the general stability with
every release. W2k were better than NT, XP are better than W2k.
Windows (I mean the NT-branch) did never eat my filesystems.
Bad combination of USB and devfs was able to do this in half
an hour, and this was *VENDOR KERNEL* that did hopefully get
more testing than that what is released to the general public.
I surely cannot recommend using 2.4 to our customers."

which seems to negate the point Alan was attempting to make.

Just thought I'd set the record straight.

NOTE: Emphasis mine.


"Everyone's got a story to tell, and everyone's got some pain.
 And so do you. Do you think you are invisble?
 And everyone's got a story to sell, and everyone is strange.
 And so are you. Did you think you were invincible?"
 	- "Invisible", Majik Alex

