Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTICSGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTICSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:06:41 -0400
Received: from holomorphy.com ([66.224.33.161]:30601 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264148AbTICSGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:06:11 -0400
Date: Wed, 3 Sep 2003 11:07:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Larry McVoy <lm@bitmover.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903180702.GQ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>, Larry McVoy <lm@bitmover.com>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com> <20030903173213.GC5769@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903173213.GC5769@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 01:07:03PM -0400, Brown, Len wrote:
>> Fortunately seek time on RAM is lower than disk;-)  Sure, parallel
>> systems are a waste of effort for running a single copy of a single
>> threaded app, but when you have multiple apps, or better yet MT apps,
>> you win.  If system performance were limited over time to the rate of
>> decrease in RAM latency, then we'd be in sorry shape.

On Wed, Sep 03, 2003 at 10:32:13AM -0700, Larry McVoy wrote:
> For a lot of applications we are.  Go talk to your buddies in the processor
> group, I think there is a fair amount of awareness that for most apps faster
> processors aren't doing any good.  Ditto for SMP.

You're thinking single-application again. Systems run more than one
thing at once.


On Wed, Sep 03, 2003 at 01:07:03PM -0400, Brown, Len wrote:
>> Back to the original off-topic...
>> An OEM can spin their motivation to focus on smaller systems in 3 ways:
>> 1. large server sales are a small % of industry units
>> 2. large server sales are a small % of industry revenue
>> 3. large server sales are a small % of industry profits
>> Only 1 is true.

On Wed, Sep 03, 2003 at 10:32:13AM -0700, Larry McVoy wrote:
> How about some data to back up that statement?
> Sun: ~11B/year and losing money, heavily server based
> Dell: ~38B/year and making money, 99% small box based
> If you were gambling with _your_ money, would you invest in Sun or Dell?

That's neither sufficient information about those two companies nor a
sufficient number of companies to make a proper empirical statement
about this. I really don't care for a stock market update, but I'm just
not going to believe anything this sketchy (from either source, actually).


-- wli
