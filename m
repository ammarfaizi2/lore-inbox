Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVDDFvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVDDFvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDDFvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:51:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44763 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261550AbVDDFvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:51:11 -0400
Date: Sun, 3 Apr 2005 22:50:37 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403225037.43945d8b.pj@engr.sgi.com>
In-Reply-To: <20050404054545.GA22190@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403152413.GA26631@elte.hu>
	<20050403160807.35381385.pj@engr.sgi.com>
	<4250A195.5030306@yahoo.com.au>
	<20050403205558.753f2b55.pj@engr.sgi.com>
	<20050404054545.GA22190@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> There's no other place to push them 

One could make a place, if the need arose.

> but trying and benchmarking it is necessary to tell for sure.

Hard to argue with that ... ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
