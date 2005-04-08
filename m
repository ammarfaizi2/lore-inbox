Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVDHFda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVDHFda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVDHFda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:33:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6051 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262659AbVDHFd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:33:27 -0400
Date: Fri, 8 Apr 2005 11:04:05 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: george@mvista.com, nickpiggin@yahoo.com.au,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
Message-ID: <20050408053405.GA5392@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050407124629.GA17268@in.ibm.com> <20050407151024.GA6565@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407151024.GA6565@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 05:10:24PM +0200, Ingo Molnar wrote:
> Interaction with VST is not a big issue right now because this only matters 
> on SMP boxes which is a rare (but not unprecedented) target for embedded 
> platforms.  

Well, I don't think VST is targetting just power management in embedded 
platforms. Even (virtualized) servers will benefit from this patch, by
making use of the (virtual) CPU resources more efficiently.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
