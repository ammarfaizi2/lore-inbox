Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbTCLUgW>; Wed, 12 Mar 2003 15:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTCLUgW>; Wed, 12 Mar 2003 15:36:22 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:24969
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261970AbTCLUgV>; Wed, 12 Mar 2003 15:36:21 -0500
Date: Wed, 12 Mar 2003 15:46:58 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030312201416.GA2433@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0303121542010.14172-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Sam Ravnborg wrote:

> On Wed, Mar 12, 2003 at 11:51:20AM -0800, Larry McVoy wrote:
> > is what davej may have typed in as comments.  We capture that as well, it
> > looks like this:
> > 
> >     revision 1.342
> >     date: 2003/03/07 15:39:16;  author: torvalds;  state: Exp;  lines: +7 -1
> >     [PATCH] kbuild: Smart notation for non-verbose output
> 
> Ho humm, I did this not Linus.
> Checked the web which is correct.
> 
> Same goes for 1.340 for the Makefile. Kai did it, not Linus.

It seems that some things that should have been attributed to me (or others)
are listed as from torvalds too.

Example: drivers/char/tty_io.c

revision 1.59
date: 2003/03/04 02:13:05;  author: torvalds;  state: Exp;  lines: +4 -6
small tty irq race fix

(Logical change 1.8144)


Nicolas

