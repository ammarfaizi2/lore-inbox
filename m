Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTAKD6I>; Fri, 10 Jan 2003 22:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTAKD6I>; Fri, 10 Jan 2003 22:58:08 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:13010 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267034AbTAKD6G>; Fri, 10 Jan 2003 22:58:06 -0500
Date: Fri, 10 Jan 2003 23:05:29 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Nvidia and its choice to read the GPL "differently"
In-reply-to: <20030110205203.A30604@hq.fsmlabs.com>
To: yodaiken@fsmlabs.com
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry Sendlosky <Larry.Sendlosky@storigen.com>,
       Richard Stallman <rms@gnu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042257928.1278.147.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com>
 <1042250324.1278.18.camel@RobsPC.RobertWilkens.com>
 <20030111020738.GC9373@work.bitmover.com>
 <1042255571.32431.43.camel@irongate.swansea.linux.org.uk>
 <20030111025449.GJ9124@work.bitmover.com>
 <1042253924.1385.70.camel@RobsPC.RobertWilkens.com>
 <20030110205203.A30604@hq.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 22:52, yodaiken@fsmlabs.com wrote:
> "fortune".  Nearly anyone can pick this up. Val Henson's mom even 

Writing fortune is probably far more complicated than writing the
kernel.  By that, of course, I mean writing the individual fortunes
which fortune spits out

It's also more useful.  The kernel, by itself, does nothing.  It's like
saying "the cpu is the most important part of the computer".  Yeah, but
without the a bios, what can you do with it?  (Actually, a lot, if you
can bootstrap the OS by other means, but you need hardware engineers to
help you with that, and I've done it.)  

An OS is just another layer in the onion..  What's nice is that in an
ideal world, that software follows standards..  Linux is still trying to
find it's way in that respect it seems (for example, today I found that
my 2.4 oss sound driver no longer works just right in the 2.5 kernel nor
is it likely to be supported in the future since some SuSE specific
sound system is replacing it -- I guess SuSE gave Torvalds some stock
options or similar.)  Also, the once perfectly functioning nvidia kernel
driver (the subject of this message) no longer works in newer kernels --
whereas if there were a standard interface for such things, nvidia could
freely keep their source closed while providing a driver that would
solve people's problems.

At least windows a few years back standardized on the wdm (windows
driver model) whereby there was a standard interface for what a driver
looked like and what it's interface to the kernel was (whether the
platform was the dos-based windows 9x or NT-based Windows 2000/XP). 
This is not to say that I'm "trolling" by extolling the virtues of
windows over linux..  I'm just pointing out what I know in this area.

-Rob

