Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTALQwF>; Sun, 12 Jan 2003 11:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTALQwF>; Sun, 12 Jan 2003 11:52:05 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:24498 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267237AbTALQwE>; Sun, 12 Jan 2003 11:52:04 -0500
Date: Sun, 12 Jan 2003 11:58:55 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Intel And Kenrel Programming (was: Nvidia is a great company)
In-reply-to: <1042389923.15051.1.camel@irongate.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Wolber <chuckw@quantumlinux.com>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042390735.1208.5.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301112346450.2270-100000@bailey.scraps.org>
 <1042382565.848.11.camel@RobsPC.RobertWilkens.com>
 <1042389923.15051.1.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 11:45, Alan Cox wrote:
> There are actually very few chips we don't have to deal with some kind
> of errata on, and the newer more complex chips generally have the larger
> collections of errata. 
> 
> One thing that has been helpful is the microcode update stuff Intel did, we
> hit  few bugs that up to date microcode kill off
> 

The hardware engineers, in my experience, will not refer to those issues
as bugs, but rather as misdocumented features... No?  I mean if an
errata is enough to work around the problem, then the documentation was
clearly the problem, and not the hardware implementation.

As per the microcode updates, I noticed RedHat 8 was autoupdating
microcode on each boot IIRC. I've since switched to Debian and don't
know that it does this.  Should I be concerned?

-Rob

