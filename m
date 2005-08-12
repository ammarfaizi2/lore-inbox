Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVHLMz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVHLMz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVHLMz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:55:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31622 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1751162AbVHLMz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:55:26 -0400
Date: Fri, 12 Aug 2005 14:55:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUGS: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16 with CONFIG_DEBUG_SLAB
Message-ID: <20050812125540.GA12156@elte.hu>
References: <200508101915.j7AJFJXe004888@cichlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508101915.j7AJFJXe004888@cichlid.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Burgess <aab@cichlid.com> wrote:

> Here is 2.6.13-rc5-RT-V0.7.52-16 SMP with CONFIG_DEBUG_SLAB set.
> How may I help?

ok, could you try the -53-05 (or later) kernel, does it work any better?

	Ingo
