Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTICRcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbTICRca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:32:30 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:48855 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264146AbTICRcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:32:20 -0400
Date: Wed, 3 Sep 2003 10:32:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Larry McVoy <lm@bitmover.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903173213.GC5769@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>, Larry McVoy <lm@bitmover.com>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 01:07:03PM -0400, Brown, Len wrote:
> Fortunately seek time on RAM is lower than disk;-)  Sure, parallel
> systems are a waste of effort for running a single copy of a single
> threaded app, but when you have multiple apps, or better yet MT apps,
> you win.  If system performance were limited over time to the rate of
> decrease in RAM latency, then we'd be in sorry shape.

For a lot of applications we are.  Go talk to your buddies in the processor
group, I think there is a fair amount of awareness that for most apps faster
processors aren't doing any good.  Ditto for SMP.

> Back to the original off-topic...
> An OEM can spin their motivation to focus on smaller systems in 3 ways:
> 
> 1. large server sales are a small % of industry units
> 2. large server sales are a small % of industry revenue
> 3. large server sales are a small % of industry profits
> 
> Only 1 is true.

How about some data to back up that statement?

Sun: ~11B/year and losing money, heavily server based
Dell: ~38B/year and making money, 99% small box based

If you were gambling with _your_ money, would you invest in Sun or Dell?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
