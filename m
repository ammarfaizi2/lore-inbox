Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265906AbSKFSId>; Wed, 6 Nov 2002 13:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbSKFSId>; Wed, 6 Nov 2002 13:08:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27890 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265906AbSKFSIc>;
	Wed, 6 Nov 2002 13:08:32 -0500
Subject: Re: NUMA scheduler BK tree
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Robert Love <rml@tech9.net>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200211061734.42713.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 10:10:42 -0800
Message-Id: <1036606243.23147.4.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 08:34, Erich Focht wrote:
> Michael, Martin,
> 
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

Erich,

This is fine with me.  Can't the core changes and and load
balancer be maintained as separate changesets within the bk
tree?  

            Michael

> Regards,
> Erich
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

