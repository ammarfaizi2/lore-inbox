Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUHSIkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUHSIkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUHSIj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:39:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61848 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263850AbUHSIjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:39:55 -0400
Date: Thu, 19 Aug 2004 10:40:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040819084001.GA4098@elte.hu>
References: <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <1092902417.8432.108.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092902417.8432.108.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2004-08-19 at 03:32, Ingo Molnar wrote:
> > i've uploaded the -P4 patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> 
> Any comments on the unmap_vmas issue?

wli indicated he's working on the pagetable zapping critical section
issue - wli?

	Ingo
