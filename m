Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132901AbRADMHm>; Thu, 4 Jan 2001 07:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRADMHe>; Thu, 4 Jan 2001 07:07:34 -0500
Received: from linuxcare.com.au ([203.29.91.49]:51972 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132901AbRADMHX>; Thu, 4 Jan 2001 07:07:23 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 4 Jan 2001 22:50:56 +1100
To: "A.D.F." <adefacc@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010104225056.C13759@linuxcare.com>
In-Reply-To: <3A546385.C50B1092@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A546385.C50B1092@tin.it>; from adefacc@tin.it on Thu, Jan 04, 2001 at 11:50:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi, I would like to know whether following limits are right for kernel
> 2.4.x:
> 
> Max. N. of CPU:			32	(SMP)

Max CPUs is 64 on 64 bit architectures (well you have to change NR_CPUS).
I am told larger than 32 cpu ultrasparcs have booted linux already.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
