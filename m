Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbULJV6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbULJV6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbULJV6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:58:55 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:51711 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261829AbULJV6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:58:51 -0500
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
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Date: Fri, 10 Dec 2004 15:58:10 -0600
Message-ID: <OFBAE8A098.EDD5F516-ON86256F66.0078AE9A-86256F66.0078AEB0@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 03:58:13 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the only recent thing added was the global RT balancer, which is not
>active under PREEMPT_DESKTOP. Maybe this code somehow interferes with
>your workload? Could you try to disable it, ...

Real life will intervene before I can get the kernel built & tested
[have to pick up the kids...]. Will try this (w/o any tracing as well)
on Monday (and see if I can put RT in a good light...).

  --Mark

