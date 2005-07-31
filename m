Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVGaGih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVGaGih (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbVGaGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 02:38:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52460 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261822AbVGaGiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 02:38:11 -0400
Date: Sun, 31 Jul 2005 08:38:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050731063852.GA611@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins> <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122785233.10275.3.camel@mindpipe>
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

u
* Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2005-07-30 at 22:52 +0200, Ingo Molnar wrote:
> > * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > 
> > > Hi Ingo,
> > > 
> > > -02 needs the attached patch to compile with my config.
> > 
> > thanks, i've released -03 with your fixes.
> > 
> 
> Does not compile with highmem enabled:

ok - i've uploaded the -52-04 patch, does that fix it for you?

	Ingo
