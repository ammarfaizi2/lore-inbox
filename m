Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUHJRWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUHJRWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUHJRRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:17:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60639 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267610AbUHJRLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:11:35 -0400
Date: Tue, 10 Aug 2004 19:12:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810171235.GA12157@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu> <1092157841.3290.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092157841.3290.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
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

> OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few
> happened during normal desktop use, and it locks up hard when starting
> jackd.  Could this have anything to do with the ALSA drivers (which I
> am compiling seperately from ALSA cvs) detecting my build system as
> i686?  I have read that the C3 is more like a 486 (with MMX & 3DNow)
> than a 686.

well, could you try M486 then?

	Ingo
