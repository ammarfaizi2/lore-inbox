Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbULOBTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbULOBTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbULOBRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:17:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4558 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261819AbULOBJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:09:13 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1103066516.12659.377.camel@cmn37.stanford.edu>
References: <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>  <20041214132834.GA32390@elte.hu>
	 <1103066516.12659.377.camel@cmn37.stanford.edu>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 20:09:12 -0500
Message-Id: <1103072952.17186.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 15:21 -0800, Fernando Lopez-Lezcano wrote:
> I don't know which change did it, but I have network connectivity in my
> athlon64 test box with 0.7.33-0! Woohoo! [*]

Wait, this works on x84-64 now?  There was a recent report on LAU that
it didn't compile.

Lee

