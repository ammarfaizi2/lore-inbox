Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270146AbUJTFod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270146AbUJTFod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269885AbUJTFoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 01:44:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63650 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270062AbUJTFkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 01:40:47 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041019180059.GA23113@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>
Content-Type: text/plain
Message-Id: <1098250845.1429.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 01:40:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 14:00, Ingo Molnar wrote:
> i have released the -U7 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7

OK, this one boots but Gnome does not start.  It hangs at "Session
Manager".  The system does not hang, but I never get to my desktop. 
Nothing useful in the logs.

While this was going on I switched to a text console and noticed that if
I enabled/ Caps Lock at just the right moment then _all_ text output
(LOGIN, PASSWORD, etc) would be in caps.  Toggling it a few times seemed
to get rid of the problem.

Any particular debug options I should try?

Lee

