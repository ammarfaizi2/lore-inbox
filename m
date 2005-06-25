Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263337AbVFYEtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbVFYEtF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbVFYEtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:49:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5300 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263337AbVFYEtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:49:00 -0400
Date: Sat, 25 Jun 2005 06:47:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050625044757.GA14979@elte.hu>
References: <20050608112801.GA31084@elte.hu> <200506212242.39113.gene.heskett@verizon.net> <20050622074054.GC16508@elte.hu> <200506220927.07874.gene.heskett@verizon.net> <20050625044129.GA12440@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625044129.GA12440@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Gene Heskett <gene.heskett@verizon.net> wrote:
> 
> > I can report that mode 4 is not at all well here.  I turned it on and 
> > changed the extraversion, built it, and when it booted, it got to this 
> > line and hung:
> > 
> > Checking to see if this processor honours the WP bit even in 
> > supervisor mode... OK.
> 
> ok, could you try the patch below, ontop of whatever tree hung for you?

also included in -V0.7.50-19 and later patches.

	Ingo
