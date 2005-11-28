Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVK1Rub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVK1Rub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVK1Rub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:50:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5308 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932137AbVK1Rua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:50:30 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051128160052.GA29540@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 12:50:19 -0500
Message-Id: <1133200220.4998.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 17:00 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Mon, 2005-11-28 at 12:48 +0100, Ingo Molnar wrote:
> > > which was the last -rt kernel that worked fine for you in 
> > > PREEMPT_DESKTOP mode?
> > 
> > It has been a long time, possibly months - I've mostly been using 
> > PREEMPT_RT.  But now I am working on a soft RT project that for 
> > various reasons would like to use the mainline kernel, and I've found 
> > it still has some scheduling bumps up to 5-7ms and am trying to 
> > identify the problem.
> 
> ok.
> 
> > Would you like me to do a binary search?
> 
> that would certainly be very helpful!
> 

OK, 2.6.13-rt12 has the same problem.  I'm trying
2.6.13-rc4-RT-V0.7.52-02 now which is the oldest thing I still have
around.

Lee

