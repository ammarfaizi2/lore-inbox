Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUIBHQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUIBHQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIBHQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:16:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29588 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267607AbUIBHPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:15:43 -0400
Date: Thu, 2 Sep 2004 09:17:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Message-ID: <20040902071717.GA20148@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <1094108653.11364.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094108653.11364.26.camel@krustophenia.net>
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

> Also there is the rt_garbage_collect issue, previously reported.  I
> have not seen this lately but I do not remember seeing that it was
> fixed.

i dont think it's fixed, please re-report it if it occurs again, there
have been many changes.

	Ingo
