Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUHaGlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUHaGlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUHaGlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:41:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6019 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266877AbUHaGkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:40:51 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040830090608.GA25443@elte.hu>
References: <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu>
Content-Type: text/plain
Message-Id: <1093934448.5403.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 02:40:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 05:06, Ingo Molnar wrote:
> i've uploaded -Q5 to:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5

This fixes the PS/2 issue.  Entropy rekeying is still a big problem:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk4-Q5#/var/www/2.6.9-rc1-bk4-Q5/trace3.txt

Otherwise, this looks pretty good.  Here is a new one, I got this
starting X:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk4-Q5#/var/www/2.6.9-rc1-bk4-Q5/trace2.txt

Lee    

