Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965472AbWJ3JIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbWJ3JIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965475AbWJ3JIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:08:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8376 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965472AbWJ3JIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:08:10 -0500
Date: Mon, 30 Oct 2006 10:07:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Jiri Kosina <jikos@jikos.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: spin_lock_irqsave_nested()
Message-ID: <20061030090712.GB28026@elte.hu>
References: <1162199005.24143.169.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162199005.24143.169.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> From: Arjan van de Ven <arjan@linux.intel.com>
> Subject: spin_lock_irqsave_nested()
> 
> Introduce spin_lock_irqsave_nested(); implementation from:
>  http://lkml.org/lkml/2006/6/1/122
> Patch from:
>  http://lkml.org/lkml/2006/9/13/258
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
