Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVADKwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVADKwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVADKwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:52:23 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60113 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261610AbVADKwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:52:18 -0500
Date: Tue, 4 Jan 2005 11:52:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-mm1-V0.7.34-00
Message-ID: <20050104105202.GA16617@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050104104830.GA20393@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104104830.GA20393@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> On Tue, Jan 04, 2005 at 10:45:18AM +0100, Ingo Molnar wrote:
> > this is mainly a straight port from 2.6.10-rc3-mm1 to 2.6.10-mm1, plus i
> > picked up a post-2.6.10-mm1 audio-driver buildsystem fix-patch. Please
> > (re-)report any new or old regressions.
> 
> Build failure.

does -01 work better? There was some leftover debugging stuff that got
generated into the patch by mistake.

	Ingo
