Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbULOA2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbULOA2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULOA11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:27:27 -0500
Received: from pop.gmx.de ([213.165.64.20]:40672 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261798AbULOAZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:25:27 -0500
X-Authenticated: #4399952
Date: Wed, 15 Dec 2004 01:43:31 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041215014331.06f02b43@mango.fruits.de>
In-Reply-To: <1103066516.12659.377.camel@cmn37.stanford.edu>
References: <20041116134027.GA13360@elte.hu>
	<20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<20041122005411.GA19363@elte.hu>
	<20041123175823.GA8803@elte.hu>
	<20041124101626.GA31788@elte.hu>
	<20041203205807.GA25578@elte.hu>
	<20041207132927.GA4846@elte.hu>
	<20041207141123.GA12025@elte.hu>
	<20041214132834.GA32390@elte.hu>
	<1103066516.12659.377.camel@cmn37.stanford.edu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Dec 2004 15:21:56 -0800
Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> I don't know which change did it, but I have network connectivity in my
> athlon64 test box with 0.7.33-0! Woohoo! [*]
> Thanks...
> -- Fernando
> 

I thought i'd just chime in. 33-0 runs excellent here (i have no
debugging or timing enabled, but xrun performance is really good (i have
seen none but app caused ones (only mild load though, will push it a bit
harder though tomorrow))..

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/
