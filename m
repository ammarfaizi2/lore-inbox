Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUJOQyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUJOQyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUJOQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:54:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:64216 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268180AbUJOQxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:53:16 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: Lee Revell <rlrevell@joe-job.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410151359.20816.dominik.karall@gmx.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <200410151359.20816.dominik.karall@gmx.net>
Content-Type: text/plain
Message-Id: <1097858925.4904.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 12:48:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 07:59, Dominik Karall wrote:
> On Friday 15 October 2004 12:26, Ingo Molnar wrote:
> > i have released the -U3 PREEMPT_REALTIME patch:
> >
> >  
> > http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-
> >U3
> 
> hi ingo!
> can you change your version string to lower case letters to avoid "problems" 
> with make-kpkg?
> if not, no problem...

Please file a Debian bug report.  make-kpkg should be able to handle
this.

Lee

