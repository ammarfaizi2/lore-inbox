Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbULIU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbULIU4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbULIU4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:56:30 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:53964 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261583AbULIU4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:56:06 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB5659CED.4FB68B70-ON86256F65.0071906C@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 14:49:50 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 02:49:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>well, i think this measurement issue needs resolving before jumping to
>any generic conclusions. Not a single trace is extremely suspect. The
>userspace timestamps are rdtsc based, or gettimeofday() based?
rdtsc. Its actually code you sent me a while ago :-) when you
suspected a measurement problem before.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

