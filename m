Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbULJFC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbULJFC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbULJFC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:02:57 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:14603 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261712AbULJFC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:02:27 -0500
Date: Thu, 9 Dec 2004 21:01:26 -0800
To: Mark_H_Johnson@raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, Amit Shah <amit.shah@codito.com>,
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041210050126.GA30282@nietzsche.lynx.com>
References: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 01:23:38PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I may take this "off line" if it goes on too much longer. A little
> "view of the customer" is good for the whole group, but if it
> gets too much into my specific application, I don't see the benefit.

Taking offline would cut the rest of the developers off from having
any empirical data to work with. It's a bad idea. The entire point
of the RT kernel and app is to characterize the behavior of the system
so that fringe events happen and so that they can be tracked down and
eventually solved. Continue on IMO. :)

bill

