Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVGPRti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVGPRti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGPRti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:49:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2208 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261357AbVGPRth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:49:37 -0400
Date: Sat, 16 Jul 2005 19:48:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: yangyi <yang.yi@bmrtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] latency logger for realtime-preempt-2.6.12-final-V0.7.51-30
Message-ID: <20050716174845.GA19240@elte.hu>
References: <1121421736.4113.329.camel@montavista2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121421736.4113.329.camel@montavista2>
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


* yangyi <yang.yi@bmrtech.com> wrote:

> Hi, Ingo
> 
> This patch can record interrupt-off latency, preemption-off latency 
> and wakeup latency in a big history array, in the meanwhile, it 
> dummies up printks produced by these latency timing.

looks pretty good! I'll look at merging your patch after KS/OLS.

	Ingo
