Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUHQIDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUHQIDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268143AbUHQIDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:03:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3730 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268142AbUHQIDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:03:48 -0400
Date: Tue, 17 Aug 2004 10:05:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: [patch] voluntary-preempt-2.6.8.1-P3
Message-ID: <20040817080512.GA1649@elte.hu>
References: <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092716644.876.1.camel@krustophenia.net>
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

> P2 will not boot for me.  It hangs right after detecting my
> (surprise!) USB mouse.

i've uploaded -P3 with the IO-APIC changes reverted to -P1:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P3

it has no other changes.

	Ingo
