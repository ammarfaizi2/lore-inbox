Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbUKEJti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUKEJti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 04:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKEJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 04:49:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35752 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262635AbUKEJtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 04:49:19 -0500
Date: Fri, 5 Nov 2004 10:49:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.11 (oops)
Message-ID: <20041105094917.GA3585@elte.hu>
References: <OF88A40911.ECF57E25-ON86256F42.006C01DC-86256F42.006C0216@raytheon.com> <20041104195206.GB11672@elte.hu> <1099620674.3137.98.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099620674.3137.98.camel@cmn37.stanford.edu>
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


* Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> I'm getting this on my athlon64 test machine with V0.7.11:

> EIP is at acpi_bus_register_driver+0x40/0x63

does vanilla 2.6.10-rc1-mm2 boot fine?

	Ingo
