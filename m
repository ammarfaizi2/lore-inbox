Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUH1XvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUH1XvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUH1XvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:51:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61885 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268134AbUH1XvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:51:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <1093727817.860.1.camel@krustophenia.net>
References: <20040823221816.GA31671@yoda.timesys>
	 <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu>  <1093727817.860.1.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1093737080.1385.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 19:51:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 17:16, Lee Revell wrote:
> On Sat, 2004-08-28 at 17:13, Ingo Molnar wrote:
> > ok, will add this to -Q4.
> > 
> 
> Hrm, Q3 broke my PS/2 keyboard.
> 

The problem goes away when I disable CONFIG_PREEMPT_HARDIRQS.  In both
cases CONFIG_PREEMPT_SOFTIRQS was enabled.

Lee

