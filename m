Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbTCLUHg>; Wed, 12 Mar 2003 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261899AbTCLUHg>; Wed, 12 Mar 2003 15:07:36 -0500
Received: from bitmover.com ([192.132.92.2]:45997 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261884AbTCLUHf>;
	Wed, 12 Mar 2003 15:07:35 -0500
Date: Wed, 12 Mar 2003 12:18:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312201815.GF7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com> <20030312201416.GA2433@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312201416.GA2433@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 09:14:16PM +0100, Sam Ravnborg wrote:
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

Right you are, looks like a bug.  I'm digging into it.  I suspect I have
an off by one delta error but I'm not sure.  Please be aware that it 
takes 4.5 hours of CPU on our fastest machine to do the conversion so 
fixed trees are probably due tomorrow.

If you want to help, see if you can find a pattern the user names, being
aware that the revision numbers don't map one to one.  

Thanks for pointing this out, this was what I wanted.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
