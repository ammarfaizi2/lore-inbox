Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263148AbUKTSsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUKTSsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUKTSsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:48:16 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35211 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263148AbUKTSsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:48:13 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041120191403.GA16262@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net>
	 <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net>
	 <20041120191403.GA16262@elte.hu>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 13:35:44 -0500
Message-Id: <1100975745.6879.35.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 20:14 +0100, Ingo Molnar wrote:
> i only tried the !PREEMPT version though - does that one work for you? 

Not sure, will test.  My goal was to see if I could get the stability
and low latency of T3 (this is low enough latency for me!) with the new
versions.

> Also, please send me the .config that produces the failing kernel.

Sent (off-list).

Lee

