Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUL1Vmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUL1Vmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUL1Vmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:42:50 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56746 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261247AbUL1Vmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:42:49 -0500
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.32-15)
From: Lee Revell <rlrevell@joe-job.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@kihontech.com>, Ingo Molnar <mingo@elte.hu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 16:42:44 -0500
Message-Id: <1104270164.20714.31.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 17:23 +0100, Esben Nielsen wrote:
> I am afraid NVidia cards and preempt realtime is far in the future :-(

Not necessarily.  I am sure many of Nvidia's potential customers want to
do high end simulation and that requires an RT capable OS and good
graphics hardware.  If many people end up using RT preempt for high end
simulator applications, like several who have posted on this list, then
it seems like it would a good fit.

Lee

