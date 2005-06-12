Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVFLHAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVFLHAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 03:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVFLHAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 03:00:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29633 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261890AbVFLG71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:59:27 -0400
Date: Sun, 12 Jun 2005 08:49:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050612064939.GB4897@elte.hu>
References: <20050608112801.GA31084@elte.hu> <1118507720.12860.8.camel@twins> <20050611184819.GA21033@elte.hu> <200506112140.36352.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506112140.36352.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> >   * clears out immediately (and will be freed).
> >-
> 
> I just tried to build the V0.7.48-12 version, preempt mode 3, no 
> hardirq's, and got this:

does -48-13 work any better?

	Ingo
