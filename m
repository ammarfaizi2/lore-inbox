Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVCKUyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVCKUyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVCKUvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:51:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27334 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261500AbVCKUrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:47:04 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Lee Revell <rlrevell@joe-job.com>
To: rostedt@goodmis.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>
	 <1108789704.8411.9.camel@krustophenia.net>
	 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
	 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain>
	 <20050311095747.GA21820@elte.hu>
	 <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
	 <20050311101740.GA23120@elte.hu>
	 <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
	 <20050311024322.690eb3a9.akpm@osdl.org>
	 <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
	 <20050311153817.GA32020@elte.hu>
	 <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 15:46:59 -0500
Message-Id: <1110574019.19093.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 15:39 -0500, Steven Rostedt wrote:
> I'm leaving now for the weekend, so I won't be able to respond to anyone
> till Monday.  I'll also run this patch over the weekend while compiling
> the kernel in an endless loop

I'll test this with PREEMPT_DESKTOP and data=ordered also and see how it
goes.

Lee

