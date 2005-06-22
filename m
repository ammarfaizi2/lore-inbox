Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVFVIBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVFVIBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVFVHxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:53:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56982 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262906AbVFVHuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:50:23 -0400
Date: Wed, 22 Jun 2005 09:49:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
Message-ID: <20050622074937.GE16508@elte.hu>
References: <Pine.OSF.4.05.10506220109490.17063-100000@da410.phys.au.dk> <Pine.OSF.4.05.10506220113250.17063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506220113250.17063-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Yep, just as I pressed sent before I saw the following:

ok, i'll have to look at the latency trace of this.

> threshold violated: 28.0% (273usec)

btw., are you sure this happened with latency timing/tracing disabled?  
(the printks will disturb the rtc_wakeup test).

	Ingo
