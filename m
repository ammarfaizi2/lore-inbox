Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUHBHzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUHBHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUHBHzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 03:55:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32913 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266333AbUHBHzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 03:55:05 -0400
Date: Mon, 2 Aug 2004 09:56:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
Message-ID: <20040802075616.GE8332@elte.hu>
References: <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <1091411152.973.1.camel@mindpipe> <1091412858.973.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091412858.973.6.camel@mindpipe>
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

> On Sun, 2004-08-01 at 21:45, Lee Revell wrote:
> > I will post numbers soon.
> 
> I will be out of town for a few days, so this is the last batch.  On my
> hardware at least, all the latency problems have been resolved.

> 55      2
> 56      2

nice. I'd not worry about the identity of the -M5 latencies too much if
they are gone in -O2.

	Ingo
