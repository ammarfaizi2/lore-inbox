Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbTAVQJC>; Wed, 22 Jan 2003 11:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTAVQJC>; Wed, 22 Jan 2003 11:09:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13206 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261686AbTAVQJB>; Wed, 22 Jan 2003 11:09:01 -0500
Date: Wed, 22 Jan 2003 08:17:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
cc: Erich Focht <efocht@ess.nec.de>, Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
Message-ID: <35190000.1043252260@titus>
In-Reply-To: <003301c2c235$2f3123c0$29060e09@andrewhcsltgw8>
References: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain> <1043205347.5161.42.camel@kenai> <003301c2c235$2f3123c0$29060e09@andrewhcsltgw8>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Michael,  my experience has been that 2.5.59 loaded up the first node before
> distributing out tasks (at least on kernbench). 

Could you throw a printk in map_cpu_to_node and check which cpus come out 
on which nodes?

> I'll try to get some of these tests on x440 asap to compare.

So what are you running on now? the HT stuff?

M.

