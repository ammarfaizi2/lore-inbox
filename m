Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbUKHWkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUKHWkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKHWkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:40:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64433 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261282AbUKHWkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:40:18 -0500
Date: Tue, 9 Nov 2004 00:42:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.21
Message-ID: <20041108234219.GB21550@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <200411081500.00444.norberto+linux-kernel@bensa.ath.cx> <418FC299.4030602@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418FC299.4030602@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >Unfortunately, it seems corrupted.

> Yeah, what he said. :)

i've uploaded -V0.7.22, please try that instead.

	Ingo
