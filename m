Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUKSIxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUKSIxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUKSIxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:53:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36282 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261313AbUKSIxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:53:04 -0500
Date: Fri, 19 Nov 2004 10:54:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041119095451.GC27642@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94> <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100818448.3476.17.camel@localhost>
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


* Christian Meder <chris@onestepahead.de> wrote:

> This just leaves me with the mysterious traceless jvm related crash.
> I'll do my best to get a trace ;-)

it would be equally useful to somehow reproduce the lockup with public
software only, and post the precise steps how to reproduce it.

	Ingo
