Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUHSObJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUHSObJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUHSOao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:30:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56268 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266254AbUHSOab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:30:31 -0400
Date: Thu, 19 Aug 2004 16:32:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040819143205.GA19434@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040819132837.2c5403f4@mango.fruits.de> <1092914613.830.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092914613.830.7.camel@krustophenia.net>
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

> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> > 
> > Hi, this patch doesn't really apply cleanly. Do i need to worry about
> > the "fuzz" and the offsets?
> 
> Does not seem to hurt anything.  Ingo probably has some differences in
> his tree, the 'fuzz' just means that patch was smart enough to figure
> out that they don't matter.

yeah, it shouldnt be an issue, until there's no reject. (I'll rebuild my
tree because i thought i have a vanilla tree, but apparently not.)

	Ingo
