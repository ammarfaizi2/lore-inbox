Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVDCXPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVDCXPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVDCXPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:15:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11722 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261956AbVDCXPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:15:34 -0400
Date: Sun, 3 Apr 2005 16:15:22 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403161522.6e83a231.pj@engr.sgi.com>
In-Reply-To: <20050403142959.GB22798@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403142959.GB22798@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> how close are these numbers to the real worst-case migration costs on 
> that box? What are the cache sizes and what is their hierarchies?
>  ...
> is there any workload that shows the same scheduling related performance 
> regressions, other than Ken's $1m+ benchmark kit?

I'll have to talk to some people Monday and get back to you.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
