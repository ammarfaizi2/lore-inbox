Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbUKRWpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbUKRWpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUKRWnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:43:23 -0500
Received: from mail.onestepahead.de ([62.96.100.59]:52969 "EHLO
	mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S262975AbUKRWle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:41:34 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041118204239.GA5281@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <1100732223.3472.10.camel@localhost>
	 <20041118155411.GB12483@elte.hu> <1100790475.3397.3.camel@localhost>
	 <20041118204239.GA5281@elte.hu>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 23:41:29 +0100
Message-Id: <1100817690.3476.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 21:42 +0100, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > Thanks, will try soon and report. There was another trace in my log of
> > the vdr/router box which seemed unrelated to the bridging traces.
> 
> does the patch below fix that message?

Yesss. This patch applied on top of 0.7.29-0 removes all warning
messages (bridging/dvb) in my vdr/router box.

Thanks,


			Christian

-- 
Christian Meder, email: chris@onestepahead.de

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

