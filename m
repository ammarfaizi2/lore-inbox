Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUHPD0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUHPD0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHPD0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:26:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56295 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267387AbUHPD0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:26:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816032036.GA11598@elte.hu>
References: <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu>
	 <20040816025846.GA10240@elte.hu>
	 <1092625901.867.130.camel@krustophenia.net>
	 <20040816031420.GA10919@elte.hu>
	 <1092626132.867.132.camel@krustophenia.net>
	 <20040816032036.GA11598@elte.hu>
Content-Type: text/plain
Message-Id: <1092626817.867.138.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 23:26:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:20, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > did you try mlock-test.cc too? Just to make sure that mlock-test.cc is
> > > equivalent to mlockall-test.cc.
> > 
> > That attachment was also missing.
> 

mlock-test.cc does seem equivalent to mlockall-test.cc.  `mlock-test
10000' produces a ~5ms xrun.

Lee

