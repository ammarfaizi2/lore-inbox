Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284133AbRLROdS>; Tue, 18 Dec 2001 09:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284117AbRLROdH>; Tue, 18 Dec 2001 09:33:07 -0500
Received: from [198.17.35.35] ([198.17.35.35]:36051 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S284122AbRLROdD>;
	Tue, 18 Dec 2001 09:33:03 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A05@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The direction linux is taking
Date: Tue, 18 Dec 2001 06:32:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Are we satisfied with the source code control system ?

Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
a good job with source control.

The fact the 'source control' is a person and not a piece
of software is irrelevant.

> 2. Is there enough planning for documentation ? As another
> poster mentioned, there are new API and we dont know about
> them.

Although this seems annoying, it's just one facet of the
primary difference between Linux and a commercially based
kernel : if you want to know how something works and how
it's being developed, then you MUST participate, in this
and other mailing lists.

I, for example, don't particularly care about the structures
that define the block interfaces in the kernel : I don't use
them.  I do, however, care about networking things, so I follow
linux-kernel and linux-net (and several other lists) to make
sure I'm up to date.  I am applying an inherent trust in the
people developing the block code, trusting that they will do
a good job and have a stable platform for my networking needs :)

> 3. There is no central bug tracking database. At least people
> should know the status of the bugs they have found with some
> releases.

There is no central product, so there can be no central bug track.
(see below)

> 4. Aggressive nature of this mailing list itself may be a
> turn off to many who would like to contribute.

You're missing something again.

I think this is a FAQ, so maybe we can develop a form response
here.  Feel free to edit the following :

What is Linux?  (The LKML definition)
Linux is a free, open source kernel that is used by many people
as the center for their operating system.  The operating system
as a whole is NOT Linux.  Linux is just the kernel.

"RedHat Linux" is an example of an entire operating system that
uses the Linux kernel and adds lots of other software around it
to make an entire operating system.

Similarly, Lineo makes an embedded product that starts with the
same kernel code.  It doesn't target ANY of the same users that
RedHat Linux targets, but that doesn't make it any less significant.

Why is this distinction important?  Because in LKML we are not
trying to define the way that the kernel is used, we are not
trying to take over the desktop world, we are not trying to
take over the supercomputing world, and we are not trying to
become the next microsoft.  We are trying to make the best
kernel available, and that means that we support dozens of
different hardware platforms and thousands of different
operating environments.

LKML is a place where lots of developers who work on the Linux
kernel talk about different things (usually) pertaining to the
kernel source code and ways of improving it, by bug fixing, by
feature additions, or by code/API re-writing.

If you've worked in a pure development environment then you have
probably observed that people with ideas can become quite vocal
when defending their ideas, and because LKML is email based we
probably seem to be more, ah, vocal than most.  If you can't
handle this kind of environment, then stick to Kernel Traffic.
(http://kt.zork.net/)

Does that answer your question?

Dana Lacoste
Linux Developer
Ottawa, Canada
