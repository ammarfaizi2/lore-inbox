Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271753AbRH0PVQ>; Mon, 27 Aug 2001 11:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271756AbRH0PVG>; Mon, 27 Aug 2001 11:21:06 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:60581 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S271753AbRH0PUz>; Mon, 27 Aug 2001 11:20:55 -0400
Date: Mon, 27 Aug 2001 17:20:47 +0200
From: Cliff Albert <cliff@oisec.net>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, nigel@nrg.org
Subject: Re: Updated Linux kernel preemption patches
Message-ID: <20010827172047.A28581@oisec.net>
In-Reply-To: <998877465.801.19.camel@phantasy> <20010827093835.A15153@oisec.net> <998919973.1782.65.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998919973.1782.65.camel@phantasy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 09:46:12AM -0400, Robert Love wrote:

> > Kernel won't compile when this patch is applied to 2.4.8-ac12
> 
> is CONFIG_SMP set? the preempt patch and SMP are untested together.

Single CPU, no CONFIG_SMP set

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
