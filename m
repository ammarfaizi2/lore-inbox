Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTEJPI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTEJPI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:08:59 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:5535 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264335AbTEJPIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:08:55 -0400
Date: Sat, 10 May 2003 08:21:20 -0700
From: Larry McVoy <lm@bitmover.com>
To: Paul.Clements@steeleye.com
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Pavel Machek <pavel@ucw.cz>, John Levon <levon@movementarian.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: bkcvs not up-to-date?
Message-ID: <20030510152120.GA24310@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Paul.Clements@steeleye.com,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Pavel Machek <pavel@ucw.cz>, John Levon <levon@movementarian.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>
References: <3EB9ACE1.405@gmx.net> <Pine.LNX.4.10.10305072233360.15498-100000@clements.sc.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10305072233360.15498-100000@clements.sc.steeleye.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be fixed now.  We had a bad disk on kernel.bkbits.net.

On Wed, May 07, 2003 at 10:36:42PM -0400, Paul Clements wrote:
> On Thu, 8 May 2003, Carl-Daniel Hailfinger wrote:
> > 
> > Pavel Machek wrote:
> > > 
> > >>>and checked out the tree, but cvs log Makefile still indicates 2.5.68
> > >>>is the lastest version. What am I doing wrong?
> > >>
> > >>I have the same problem, the CVS gateway got stuck some point in the
> > >>middle of 2.5.68 and has had no apparen t updates since
> > > 
> > > 
> > > Its even worse: part of updates gets there. Like CREDITS file is
> > > up-to-date but Makefile is not.
> 
> Yeah, I'm getting errors trying to load loop.ko, that looks kind of
> suspicious...loop has been working...of course I guess it could be the
> regularly scheduled breakage...
> 
> --
> Paul
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
