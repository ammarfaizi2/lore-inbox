Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVDDHi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVDDHi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVDDHi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:38:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48601 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261151AbVDDHi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:38:56 -0400
Date: Mon, 4 Apr 2005 00:37:08 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050404003708.4574f26b.pj@engr.sgi.com>
In-Reply-To: <20050404064832.GA23312@elte.hu>
References: <20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403152413.GA26631@elte.hu>
	<20050403160807.35381385.pj@engr.sgi.com>
	<4250A195.5030306@yahoo.com.au>
	<20050403205558.753f2b55.pj@engr.sgi.com>
	<1112594184.5077.9.camel@npiggin-nld.site>
	<20050403233816.71a6dd4b.pj@engr.sgi.com>
	<20050404064832.GA23312@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> the problem i mentioned earlier is that there is no other use

Eh ... whatever.  The present seems straight forward enough, with a
simple sched domain tree and your auto-tune migration cost calculation
bolted directly on top of that.

I'd better leave the futures to those more experienced than I.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
