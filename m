Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270334AbTGRUtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTGRUtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:49:00 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:45248 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270334AbTGRUs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:48:59 -0400
Date: Fri, 18 Jul 2003 14:03:53 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: rms@gnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper
Message-ID: <20030718210353.GB658@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Trever L. Adams" <tadams-lists@myrealbox.com>, rms@gnu.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E19dbGS-00026T-9R@fencepost.gnu.org> <1058558982.2479.28.camel@aurora.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058558982.2479.28.camel@aurora.localdomain>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> McVoy, changing the protocol would be extremely stupid.  

There are problems with the current protocol which can't be fixed without
a protocol rev, problems that many of the kernel developers have asked us
to fix.  Sooner or later we are going to fix them and then there will be
a protocol rev.  It's possible we might do one for legal reasons but I
doubt it.  I was just pointing out to Rory that if he insisted on doing
something in direct violation of our license it wouldn't do him any good
in the long run.

> McVoy, thank you for helping Linus, Cox, Miller et al scale better.  As

My pleasure.  At least that part of all of this has worked out pretty
well.  We still think BK is nowhere near good enough, there is a lot left
to be done.  I just spent the day with one of the MySQL founders talking
about tools for doing reviews, I think those could help.  It might be very
cool, for example, if there was a way to distribute the review process
and have everyone looking over code, recording notes about possible
problems, etc.  Then Dave could grab an espresso, hit the web site,
look over the code he cares about, see the reviews, fix it, move on.
It's sort of "attach the bug report directly to the code" rather than
have a bug report.  Don't know if it will work or not but we may try it.
Stuff like that is potentially useful and part of the reason we think
we're nowhere near done.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
