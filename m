Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVDDH3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVDDH3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVDDH3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:29:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62678 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261696AbVDDH3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:29:34 -0400
Date: Mon, 4 Apr 2005 00:27:48 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050404002748.23752b85.pj@engr.sgi.com>
In-Reply-To: <20050404065040.GB23312@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403152413.GA26631@elte.hu>
	<20050403160807.35381385.pj@engr.sgi.com>
	<20050404065040.GB23312@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> agreed - i've changed it to domain_distance() in my tree.

Good - cool - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
