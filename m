Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbULOCFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbULOCFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 21:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULOCFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 21:05:35 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:40634 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261786AbULOCFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 21:05:10 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1103072952.17186.0.camel@krustophenia.net>
References: <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>  <20041214132834.GA32390@elte.hu>
	 <1103066516.12659.377.camel@cmn37.stanford.edu>
	 <1103072952.17186.0.camel@krustophenia.net>
Content-Type: text/plain
Organization: 
Message-Id: <1103076261.12657.709.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Dec 2004 18:04:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 17:09, Lee Revell wrote:
> On Tue, 2004-12-14 at 15:21 -0800, Fernando Lopez-Lezcano wrote:
> > I don't know which change did it, but I have network connectivity in my
> > athlon64 test box with 0.7.33-0! Woohoo! [*]
> 
> Wait, this works on x84-64 now?  There was a recent report on LAU that
> it didn't compile.

The machine has an athlon64 but it is running 32 bit fc2. I have not
tried to build (yet) on 64 bit fcx.

-- Fernando


