Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVF1Pb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVF1Pb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVF1Pb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:31:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26801 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262061AbVF1Pb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:31:57 -0400
Date: Tue, 28 Jun 2005 17:31:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>,
       Chuck Harding <charding@llnl.gov>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050628153139.GA2348@elte.hu>
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu> <200506250919.52640.gene.heskett@verizon.net> <200506251039.14746.gene.heskett@verizon.net> <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov> <1119902991.4794.5.camel@dhcp153.mvista.com> <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain> <20050628081843.GA16455@elte.hu> <20050628091222.GA30629@elte.hu> <42C16C1F.20202@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C16C1F.20202@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> >i've also uploaded -50-27 in which i've improved the irq-flags debugging 
> >code.
> 
> Hi Ingo,
> check_raw_flags needs to be exported. The attached one-line patch is 
> against -V0.7.50-29.

thanks, i've uploaded the -30 patch with your fix included.

	Ingo
