Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUKSJMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUKSJMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUKSJKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:10:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48298 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261325AbUKSJDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:03:53 -0500
Date: Fri, 19 Nov 2004 11:05:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041119100541.GA28243@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <419D13D3.8020409@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419D13D3.8020409@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.1i
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
> >i have released the -V0.7.29-0 Real-Time Preemption patch, 
> 
> Hi,
> is it supposed to work on x86_64? It doesn't compile.

not at the moment - it needs the timer interrupt threading changes.

	Ingo
