Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbUKJOEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUKJOEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUKJOC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:02:57 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:59570 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261945AbUKJN4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:56:45 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 14:58:11 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
References: <20041021132717.GA29153@elte.hu> <20041109160544.GA28242@elte.hu> <200411101452.36007.annabellesgarden@yahoo.de>
In-Reply-To: <200411101452.36007.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411101458.11258.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 10 November 2004 14:52 schrieb Karsten Wiese:
> Am Dienstag 09 November 2004 17:05 schrieb Ingo Molnar:
> > 
> > i have released the -V0.7.23 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> Hi
> 
> On SMP/HT/P4 I get:
>  BUG: lock held at task exit time!

Forgot to write that this happened with V0.7.24.
