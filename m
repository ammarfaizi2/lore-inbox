Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUKZTmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUKZTmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbUKZTli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:41:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20931 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262468AbUKZT2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:13 -0500
Message-ID: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
Date: Fri, 26 Nov 2004 12:12:56 -0000 (WET)
Subject: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
X-OriginalArrivalTime: 26 Nov 2004 12:14:11.0257 (UTC) FILETIME=[6FDBE290:01C4D3B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo et al.

(Sorry on the previous post, touched the wrong button :)


I'm sending (sent) some XRUN latencies captured just a minute ago.

  xruntrace1.0.tar.gz
     - scripts used for xrun trace capture automation

  xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-7.tar.gz
     - actual xrun traces captured while running jackd on RT-V0.7.31-7

  config-2.6.10-rc2-mm3-RT-V0.7.31-7.gz
     - kernel configuration as of my laptop, taken from /proc/config.gz

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



