Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVHPCtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVHPCtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 22:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVHPCtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 22:49:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52372 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964862AbVHPCtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 22:49:50 -0400
Date: Tue, 16 Aug 2005 07:41:19 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050816021119.GD4731@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050812201946.GA5327@in.ibm.com> <200508140053.21056.kernel@kolivas.org> <20050813164618.GA4659@in.ibm.com> <200508141018.29668.kernel@kolivas.org> <6189ECD1-1CE7-4E36-B9F4-FD4D9E5871FA@mac.com> <20050815154726.GB4731@in.ibm.com> <1124123963.4722.9.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124123963.4722.9.camel@leatherman>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 09:39:22AM -0700, john stultz wrote:
> The timer_opts interface is the existing interface, my work replaces it
> and separates timekeeping from the timer interrupt.
> 
> You can find a cumulative version of my patch here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/0982.html

Oops ..Thanks for pointing it out! Will try this patch and let you
know how stable time is with dyn-tick.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
