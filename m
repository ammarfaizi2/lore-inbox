Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUJST6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUJST6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUJST6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:58:22 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:36100 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267536AbUJST55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 15:57:57 -0400
Date: Tue, 19 Oct 2004 12:57:27 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
Message-ID: <20041019195727.GA16453@nietzsche.lynx.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019180059.GA23113@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 08:00:59PM +0200, Ingo Molnar wrote:
> 
> i have released the -U7 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7

You should seriously think about using a kind of bitkeeper or CVS stle
system so that multipule folks can dump stuff into it rapidly. This
project is large enough that it needs some kind of facility like that.

bill

