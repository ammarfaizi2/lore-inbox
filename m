Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUIOKPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUIOKPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUIOKNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:13:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9702 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264389AbUIOKLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:11:39 -0400
Date: Wed, 15 Sep 2004 12:12:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915101250.GA3538@elte.hu>
References: <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095210126.2406.70.camel@krustophenia.net> <20040915013925.GF9106@holomorphy.com> <20040915095614.GB1629@elte.hu> <20040915095723.GK9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915095723.GK9106@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> I had the buggy code being associated with BKL use in mind as a motive
> for the BKL sweeps etc., and wasn't referring to any pending changes.

ok, fair enough.

	Ingo
