Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbUKTMSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUKTMSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUKTMRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:17:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18590 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262969AbUKTMPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:15:19 -0500
Date: Sat, 20 Nov 2004 14:17:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Shane Shrybman <shrybman@aei.ca>
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041120131744.GC8926@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94> <1100814616.10544.6.camel@krustophenia.net> <20041119095607.GD27642@elte.hu> <1100879045.4106.4.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100879045.4106.4.camel@mars>
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


* Shane Shrybman <shrybman@aei.ca> wrote:

> On Fri, 2004-11-19 at 04:56, Ingo Molnar wrote:
> 
> > 0.7.29-1 fixes a similar module-unload problem reported by Christian
> > Meder, could you try it?
> > 
> > 	Ingo
> > 
> 
> Hi, just tried V0.7.29-1 with the ivtv module and I got this oops:

hm, does vanilla 2.6.10-rc2-mm2 work?

	Ingo
