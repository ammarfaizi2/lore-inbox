Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWFHUAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWFHUAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWFHUAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:00:35 -0400
Received: from www.tglx.de ([213.239.205.147]:49383 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964957AbWFHUAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:00:34 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149796339.4266.114.camel@cog.beaverton.ibm.com>
References: <20060607211455.GA6132@elte.hu>
	 <1149756709.11429.5.camel@Homer.TheSimpsons.net>
	 <1149796339.4266.114.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 22:01:10 +0200
Message-Id: <1149796871.5257.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 12:52 -0700, john stultz wrote:

> This fix from Andrew's tree was missed:
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/broken-out/hangcheck-remove-monotomic_clock-on-x86.patch
> 

Thanks, it's also missing in hrt. I put it there and update -rt then.

	tglx


