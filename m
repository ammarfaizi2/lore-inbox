Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVDAIBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVDAIBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVDAIBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:01:01 -0500
Received: from convulsion.choralone.org ([80.68.90.157]:2067 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S262663AbVDAIAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:00:23 -0500
Date: Fri, 1 Apr 2005 09:00:22 +0100
From: Dave Jones <davej@kernelslacker.org>
To: linux-kernel@vger.kernel.org
Subject: Free Linux-like kernel sources for x86-64
Message-ID: <20050401080022.GA10834@kernelslacker.org>
Mail-Followup-To: Dave Jones <davej@kernelslacker.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you pine for the nice days of Linux-1.1, when men were men and wrote
their own device drivers? Are you without a nice project and just dying
to cut your teeth on a OS you can try to modify for your needs? Are you
finding it frustrating when everything works on Linux? No more all-
nighters to get a nifty program working? Then this post might be just
for you :-)

I'm working on a free version of a Linux-lookalike for x86-64 computers.
It has finally reached the stage where it's even usable (though may not be
depending on what you want), and I am willing to put out the sources for wider
distribution.  It is just version 0.02 (+1 (very small) patch already), but
I've successfully run bash/gcc/gnu-make/gnu-sed/compress etc under it.

Sources for this pet project of mine can be found at http://www.kernelslacker.org/davix
The directory also contains some README-file and a couple of binaries to work under
Davix[*] (bash, update and gcc, what more can you ask for :-).

Full kernel source is provided.  The system is able to compile "as-is" and
has been known to work.  Heh.
Sources to the binaries (bash and gcc) can be found at the same place in
/pub/software/.

ALERT! WARNING! NOTE! These sources still need Linux to be compiled
(and gcc-4.0, possibly 3.x, haven't tested), and you need Linux to
set it up if you want to run it, so it is not yet a standalone system
for those of you without Linux. I'm working on it. You also need to be
something of a hacker to set it up (?), so for those hoping for an
alternative to Linux-x86-64, please ignore me. It is currently meant for
hackers interested in operating systems and x86-64's with access to Linux.

The system needs an AT-compatible harddisk (IDE is fine) and EGA/VGA. If
you are still interested, please ftp the README/RELNOTES, and/or mail me
for additional info.

I can (well, almost) hear you asking yourselves "why?".  Hurd will be
out in a year (or two, or next month, who knows), and I've already got
Linux.  This is a program for hackers by a hacker.  I've enjouyed doing
it, and somebody might enjoy looking at it and even modifying it for
their own needs.  It is still small enough to understand, use and
modify, and I'm looking forward to any comments you might have.

I'm also interested in hearing from anybody who has written any of the
utilities/library functions for Linux. If your efforts are freely
distributable (under copyright or even public domain), I'd like to hear
from you, so I can add them to the system. I'm using Ulrich Dreppers glibc
right now (thanks for a nice and working system Uli), and similar works
will be very wellcome. Your (C)'s will of course be left intact. Drop me
a line if you are willing to let me use your code.

Davej

[*] Yes, the name sucks, but its all some other guys fault.
    http://www.uwsg.iu.edu/hypermail/linux/kernel/9902.2/0288.html

