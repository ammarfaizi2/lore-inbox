Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUAWVEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUAWVEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:04:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47306 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266627AbUAWVEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:04:45 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com>
References: <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074800554.21658.68.camel@cog.beaverton.ibm.com>
	 <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074801242.21658.71.camel@cog.beaverton.ibm.com>
	 <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074806504.21658.76.camel@cog.beaverton.ibm.com>
	 <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074885449.12446.27.camel@localhost>
	 <20040123193635.GA492@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074888405.12447.41.camel@localhost>
	 <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com>
Content-Type: text/plain
Message-Id: <1074891881.12447.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 23 Jan 2004 13:04:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 12:38, timothy parkinson wrote:
> no problem, i'll take it from here.
> 
> * Running with SpeedStep (this is a cpu thing i assume?) could cause this.
> * Not having DMA enabled on your hard disk(s) could cause this.  See the hdparm
>   utility to enable it.
> * Incorrect TSC synchronization on SMP systems could cause this.
> * Anything else?

Not that I can think of right off. Sounds good.

Thanks!
-john


