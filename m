Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUJPCgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUJPCgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 22:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUJPCgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 22:36:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15821 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268553AbUJPCgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 22:36:11 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
In-Reply-To: <1097888438.6737.63.camel@krustophenia.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu>
	 <1097888438.6737.63.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1097894120.31747.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 22:35:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 21:00, Lee Revell wrote:
> On Fri, 2004-10-15 at 06:26, Ingo Molnar wrote:
> > i have released the -U3 PREEMPT_REALTIME patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> 
> Does not compile.  .config attached:

It builds fine if CONFIG_SMP is set.  Am I really the only person
running this on UP?

Lee

