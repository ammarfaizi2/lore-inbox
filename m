Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbULJFPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbULJFPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbULJFPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:15:22 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:64130 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261688AbULJFPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:15:17 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Bill Huey <bhuey@lnxw.com>
Cc: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041210050126.GA30282@nietzsche.lynx.com>
References: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com>
	 <20041210050126.GA30282@nietzsche.lynx.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 10 Dec 2004 00:14:16 -0500
Message-Id: <1102655656.3238.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 21:01 -0800, Bill Huey wrote:
> On Thu, Dec 09, 2004 at 01:23:38PM -0600, Mark_H_Johnson@raytheon.com wrote:
> > I may take this "off line" if it goes on too much longer. A little
> > "view of the customer" is good for the whole group, but if it
> > gets too much into my specific application, I don't see the benefit.
> 
> Taking offline would cut the rest of the developers off from having
> any empirical data to work with. It's a bad idea. The entire point
> of the RT kernel and app is to characterize the behavior of the system
> so that fringe events happen and so that they can be tracked down and
> eventually solved. Continue on IMO. :)

I second the motion. It's a fun read ;-)

(just my 0.02 cents)

-- Steve
