Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTICQjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTICQjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:39:06 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:31617
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S263973AbTICQhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:37:50 -0400
Date: Wed, 3 Sep 2003 12:37:28 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903163728.GB23996@kurtwerks.com>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903043355.GC2019@zip.com.au> <20030903050859.GD10257@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903050859.GD10257@work.bitmover.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Larry McVoy:

[SMP hits memory latency wall]

> It's called asymptotic behavior.  After a while you can look at the graph
> and see that more CPUs on the same memory doesn't make sense.  It hasn't
> made sense for a decade, what makes anyone think that is changing?

Isn't this what NUMA is for, then?

Kurt
-- 
"There was a boy called Eustace Clarence Scrubb, and he almost deserved
it."
		-- C. S. Lewis, The Chronicles of Narnia
