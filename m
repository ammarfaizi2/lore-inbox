Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbVFYJMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVFYJMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbVFYJMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:12:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19104 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263077AbVFYJMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:12:39 -0400
Date: Sat, 25 Jun 2005 11:12:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050625091215.GC27073@elte.hu>
References: <20050608112801.GA31084@elte.hu> <20050625044757.GA14979@elte.hu> <200506250139.59620.gene.heskett@verizon.net> <200506250326.14998.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506250326.14998.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> It seems the transmitter only needed a goodnight kiss, so I came back 
> & built it.  So far running good, 5 minute uptime, looks good.  More 
> reports if I find any gotcha's :) Seemed to boot marginally faster 
> too, but no stopwatch timeings were done.

great. To make sure, these earlier boot failures are gone:

> I just tried to build & boot 50-17 in mode=3, no hardirq's and got the 
> same boot failure as mode 4 for 50-06 gave:

right?

	Ingo
