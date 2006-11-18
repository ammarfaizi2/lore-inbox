Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756193AbWKRG6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbWKRG6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756195AbWKRG6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:58:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41947 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1756193AbWKRG6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:58:15 -0500
Date: Sat, 18 Nov 2006 07:56:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC: 2.6 patch] remove kernel/lockdep.c:lockdep_internal
Message-ID: <20061118065650.GA32226@elte.hu>
References: <20061117235833.GO31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117235833.GO31879@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3770]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes the no longer used lockdep_internal().
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

agreed.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
