Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbULNQyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbULNQyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULNQyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:54:24 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:61070 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261557AbULNQyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:54:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: john cooper <john.cooper@timesys.com>
Cc: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <41BEF883.9000401@timesys.com>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
	 <1102722147.3300.7.camel@localhost.localdomain>
	 <41BB2785.7020006@timesys.com>
	 <1102826191.3691.44.camel@localhost.localdomain>
	 <41BE29B5.5090206@timesys.com>
	 <1103029296.3582.28.camel@localhost.localdomain>
	 <41BEF883.9000401@timesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 14 Dec 2004 11:53:46 -0500
Message-Id: <1103043226.3582.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 09:28 -0500, john cooper wrote:

> Agreed.  And I do think this mechanism has merit irrespective
> of the preemption model -- I wouldn't expect a preemptive
> approach to be available in the first prototype.
> 
> I'd hazard other likely sources of battle history dealing with
> client/server/preemption issues to be found in papers dealing with
> microkernel [who?] design of about a decade and a half ago.

OK, I understand what you're saying. Oh, and tell Scott I said "Hi".

-- Steve

