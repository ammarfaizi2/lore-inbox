Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbULIRlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbULIRlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbULIRlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:41:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6286 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261566AbULIRll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:41:41 -0500
Date: Thu, 9 Dec 2004 18:41:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Florian Schmidt <mista.tapas@gmx.net>, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209174107.GF7975@elte.hu>
References: <OF8CB9B8EE.C928A668-ON86256F65.0058B4C3@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8CB9B8EE.C928A668-ON86256F65.0058B4C3@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Don't take this message the wrong way. I strongly support what Ingo is
> doing with the 2.6 kernel. Its just sometimes the measurements don't
> seem to show the improvements everyone wants to see.

just in case it wasnt obvious ... your feedback is really useful, no
matter in what direction it goes. You have one of the most complex test
setups, so i pretty much expect your setup to trigger the most problems
as well (and it is also the hardest to analyze). I think we are fine as
long as constant progress is made (which i believe we are making, even
if seemingly not for your particular workload =B-).

	Ingo
