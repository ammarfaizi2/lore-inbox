Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUJ1Nx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUJ1Nx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUJ1Nx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:53:58 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:29648 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261675AbUJ1Nx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:53:56 -0400
Date: Thu, 28 Oct 2004 06:53:48 -0700
From: Larry McVoy <lm@bitmover.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrea Arcangeli <andrea@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041028135348.GA18099@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	James Bruce <bruce@andrew.cmu.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andrea Arcangeli <andrea@novell.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4180B9E9.3070801@andrew.cmu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually it's not that simple.  With the free BK license it's not _your_ 
> choice that affects validity; It's the choice of any person at your 
> company deciding for everyone else.  So if one OSDL employee uses the 
> free BK licence, *nobody else* at OSDL can work on an SCM, even at home 
> in their spare time.  Technically, if any one of the other 10,000 people 
> at my university work on an SCM, I can't use it either since they pay 
> me.  I try to bury my head in the sand and think that they aren't.  In 
> reality however, I can't vouch for what the other 9,999 people are 
> doing.  

The reason it is worded that way is so that we avoid the situation where
one guy is doing the work on $SCM and the other guy is sitting there 
running BK commands in order to reverse engineer BK.

We aren't going to come make a fuss if you are using BK and some other
guy is tinkering with CVS, we're not unreasonable people.  On the other
hand, that doesn't give you carte blanche, if your officemate or friend
is working on a BK replacement and you are helping him, yes, we will 
likely make a fuss.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
