Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbTCMAbL>; Wed, 12 Mar 2003 19:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261895AbTCMAbL>; Wed, 12 Mar 2003 19:31:11 -0500
Received: from bitmover.com ([192.132.92.2]:36028 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261883AbTCMAbK>;
	Wed, 12 Mar 2003 19:31:10 -0500
Date: Wed, 12 Mar 2003 16:41:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Larry McVoy <lm@bitmover.com>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030313004151.GI7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nicolas Pitre <nico@cam.org>, Larry McVoy <lm@bitmover.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030312205859.GG7275@work.bitmover.com> <Pine.LNX.4.44.0303121605360.14172-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303121605360.14172-100000@xanadu.home>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > revision 1.59
> > > date: 2003/03/04 02:13:05;  author: torvalds;  state: Exp;  lines: +4 -6
> > > small tty irq race fix
> > > 
> > > (Logical change 1.8144)
> > 
> > Yeah, I'm almost there, I'm pretty sure that what is happening is that 
> > the user name is being picked up from the changeset which is current in

OK, I think I have a fix, I'm starting another conversion and going out to
dinner.  This was a lot harder to fix than I thought, it cost me the whole
day.  I can't wait until Pavel is doing this crap.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
