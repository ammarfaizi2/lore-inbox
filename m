Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVDBVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVDBVsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDBVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:37:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261391AbVDBVYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:24:36 -0500
Date: Sat, 2 Apr 2005 13:22:51 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050402132251.5a97e754.pj@engr.sgi.com>
In-Reply-To: <20050402145351.GA11601@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> in theory the code should work fine on ia64 as well,

Nice.  I'll try it on our SN2 Altix IA64 as well.
Though I am being delayed a day or two in this
by irrelevant problems.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
