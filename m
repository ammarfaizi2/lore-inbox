Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUKHWjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUKHWjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUKHWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:39:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35505 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261275AbUKHWjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:39:42 -0500
Date: Tue, 9 Nov 2004 00:41:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.21
Message-ID: <20041108234146.GA21550@elte.hu>
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <418FAFC5.7070000@spymac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418FAFC5.7070000@spymac.com>
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


* Gunther Persoons <gunther_persoons@spymac.com> wrote:

> When trying to patch my kernel i get following notice:
> patching file include/linux/highmem.h
> patch unexpectedly ends in middle of line
> patch: **** unexpected end of file in patch

yeah ... the result of an incomplete upload. I've uploaded -V0.7.22 that
is a full patch. (no other changes)

	Ingo
