Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWIGKTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWIGKTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWIGKTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:19:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6068 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751274AbWIGKTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:19:21 -0400
Date: Thu, 7 Sep 2006 12:11:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fixing wrong comment for find_idlest_cpu()
Message-ID: <20060907101115.GB4125@elte.hu>
References: <87d5a8jlgf.wl%takeuchi_satoru@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5a8jlgf.wl%takeuchi_satoru@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com> wrote:

> Fixing wrong comment for find_idlest_cpu().
> 
> Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
