Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSKRSjP>; Mon, 18 Nov 2002 13:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSKRSjP>; Mon, 18 Nov 2002 13:39:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:1701 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264638AbSKRSjO>;
	Mon, 18 Nov 2002 13:39:14 -0500
Date: Mon, 18 Nov 2002 11:40:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Robert Love <rml@tech9.net>, Anton Blanchard <anton@samba.org>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NUMA scheduler BK tree
Message-ID: <347990000.1037648441@flay>
In-Reply-To: <200211061734.42713.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in order to make it easier to keep up with the main Linux tree I've
> set up a bitkeeper repository with our NUMA scheduler at
>        bk://numa-ef.bkbits.net/numa-sched
> (Web view:  http://numa-ef.bkbits.net/)
> This used to contain my node affine NUMA scheduler, I'll add extra
> trees when the additional patches for that are tested on top of our
> NUMA scheduler.
> 
> Is it ok for you to have it this way or would you prefer having the
> core and the initial load balancer separate?
> 
> The tree is currently in sync with bk://linux.bkbits.net/linux-2.5 and
> I'll try to keep so.

BTW, can you keep producing normal patches too, when you do an update? 
I don't use bitkeeper ...

Thanks,

Martin.


