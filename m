Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbTISUwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTISUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:52:32 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:36049 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261751AbTISUwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:52:30 -0400
Date: Fri, 19 Sep 2003 13:52:20 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Roland Bless <bless@tm.uka.de>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org, walter@tm.uka.de, winter@tm.uka.de,
       doll@tm.uka.de
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030919205220.GA19830@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Roland Bless <bless@tm.uka.de>,
	miquels@cistron.nl, linux-kernel@vger.kernel.org, walter@tm.uka.de,
	winter@tm.uka.de, doll@tm.uka.de
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030919203538.D1919@flint.arm.linux.org.uk> <20030919200117.GE1312@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919200117.GE1312@velociraptor.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 10:01:17PM +0200, Andrea Arcangeli wrote:
> Andrea - If you refuse to depend on closed software for a critical
> 	 part of your business, these links may be useful:
> 	  rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
> 	  http://www.cobite.com/cvsps/
> 	  svn://svn.kernel.org/linux-2.[46]/trunk
> -------------------------
> 
> Hope it's ok in terms of bandwidth now.
> 
> And if you don't like the text I write in my signature, I'm sorry and I
> would simply suggest you to not read it. If you need a marker to cleanup
> it reliably just ask me and I'll be glad to add it. IMHO the value those
> services provides is too high not to advertize them as much as I
> possibly can.

Then put the URL's in the FAQ and be done with it.  

I can assure you that the first time the CVS gateway has a problem it
won't come back until you have stopped being rude.  You do understand
that the SVN and RSYNC data come from the CVS gateway and that the
CVS gateway comes from BitMover and that all of this crap is hosted by
BitMover, right?  {cvs,svn}.kernel.org are cnames for kernel.bkbits.net.

Here's a suggested replacement signature, it accomplishes your goal of
advertising the services.  Why this needs to be here and not in the FAQ
is beyond me.

/*
 * SCM access to the kernel
 *
 * BitKeeper:	bk://linux.bkbits.net/linux-2.[45]
 * CVS:		:pserver:anonymous@cvs.kernel.org:/home/cvs/linux-2.[45]
 * RSYNC:	rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
 * Subversion:	svn://svn.kernel.org/linux-2.[46]/trunk
 */
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
