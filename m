Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVBAUBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVBAUBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVBAUBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:01:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45726 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262113AbVBAUBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:01:18 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Rini <trini@kernel.crashing.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050126080952.GC4771@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
	 <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net>
	 <20050126080952.GC4771@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 15:01:16 -0500
Message-Id: <1107288076.18349.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 09:09 +0100, Ingo Molnar wrote:
> thanks - i have applied all of these and have released the
> -2.6.11-rc2-V0.7.36-04 patch which can be downloaded from the usual
> place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> The -04 patch should also fix the down_write_interruptible() related
> build error reported by Lee Revell and others.

Assuming it's still available, what is the config option to get the
"User-space atomicity debugging" feature?  This feature is extremely
useful for debugging complex JACK clients, several Linux audio
developers have asked me about it but I can't find the config option
anymore.

Lee

