Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVAOPQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVAOPQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 10:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVAOPQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 10:16:35 -0500
Received: from relay00.pair.com ([209.68.1.20]:59409 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262296AbVAOPQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 10:16:29 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41E933CB.9020907@cybsft.com>
Date: Sat, 15 Jan 2005 09:16:27 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>, Bill Huey <bhuey@lnxw.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc1-V0.7.35-00
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
In-Reply-To: <20050115133454.GA8748@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.35-00 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> The two dozen split out latency patches (including PREEMPT_BKL) that
> were in -mm are in BK now, so i've rebased the -RT patchset to
> 2.6.11-rc1. It would be nice to check for regressions (or the lack of
> them), to make sure everything latency-related has been properly merged
> upstream from -mm. (so that a new splitup cycle can start.)
> 

I've not done much testing with it yet but I do have it built and 
running on my slower SMP system. Working on my UP sytem now.

kr
