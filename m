Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269405AbUICIWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269405AbUICIWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUICITV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:19:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29875 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269362AbUICINT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:13:19 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Luke Yelavich <luke@audioslack.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, free78@tin.it
In-Reply-To: <20040903080930.GA30814@luke-laptop.yelavich.home>
References: <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
	 <1094181447.4815.6.camel@orbiter>
	 <1094192788.19760.47.camel@krustophenia.net>
	 <20040903063658.GA11801@elte.hu>
	 <1094194157.19760.71.camel@krustophenia.net>
	 <20040903070500.GB13100@elte.hu>
	 <1094197233.19760.115.camel@krustophenia.net>
	 <20040903080930.GA30814@luke-laptop.yelavich.home>
Content-Type: text/plain
Message-Id: <1094199195.19760.136.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 04:13:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 04:09, Luke Yelavich wrote:
> On Fri, Sep 03, 2004 at 05:40:34PM EST, Lee Revell wrote:
> > On Fri, 2004-09-03 at 03:05, Ingo Molnar wrote:
> Well with Lee's help, I think I have identified an ICE1712 sound driver issue,
> but this is yet to be determined.

Hmm, this one is still not fixed, using the latest VP patches?

What are the symptoms again?

Lee

