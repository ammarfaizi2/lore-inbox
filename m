Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVCYWoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVCYWoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVCYWlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:41:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58061 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261861AbVCYWks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:40:48 -0500
Date: Fri, 25 Mar 2005 23:39:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
Message-ID: <20050325223959.GA24800@elte.hu>
References: <20050325145908.GA7146@elte.hu> <1111790009.23430.19.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111790009.23430.19.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2005-03-25 at 15:59 +0100, Ingo Molnar wrote:
> > i have released the -V0.7.41-10 Real-Time Preemption patch, which can be 
> > downloaded from the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> I get zillions of "return type defaults to int" warnings trying to
> compile this with PREEMPT_DESKTOP.

i've uploaded -41-11 which should fix it.

	Ingo
