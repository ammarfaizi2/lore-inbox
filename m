Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268093AbUHQEXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268093AbUHQEXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUHQEXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:23:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40106 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268093AbUHQEXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:23:08 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816120933.GA4211@elte.hu>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <20040816120933.GA4211@elte.hu>
Content-Type: text/plain
Message-Id: <1092716644.876.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 00:24:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 08:09, Ingo Molnar wrote:
> here's -P2:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2
> 
> Changes since -P1:
> 
>  - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)
> 
>  - yet another shot at trying to fix the IO-APIC/USB issues.
> 
>  - mcount speedups - tracing should be faster
> 

P2 will not boot for me.  It hangs right after detecting my (surprise!)
USB mouse.

Lee

