Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUKRXfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUKRXfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKRXeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:34:01 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:31945 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261168AbUKRXdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:33:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
	 <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
	 <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
	 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu>
	 <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 16:50:15 -0500
Message-Id: <1100814616.10544.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 14:46 +0000, Rui Nuno Capela wrote:
> I'm still seeing this sometimes (not everytime) on my P4/UP laptop while
> shutting down ALSA modules.

Same thing here (BUG on unload ALSA modules) with 0.7.27-10 FWIW.

Lee


