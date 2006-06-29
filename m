Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWF2VCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWF2VCE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWF2VCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:02:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5819 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932641AbWF2VCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:02:02 -0400
Date: Thu, 29 Jun 2006 22:57:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Michael Tokarev <mjt@tls.msk.ru>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] small kernel/sched.c cleanup
Message-ID: <20060629205712.GA31945@elte.hu>
References: <20060613195509.GF24167@rhlx01.fht-esslingen.de> <448F2C97.2090103@tls.msk.ru> <20060629194320.GA11245@rhlx01.fht-esslingen.de> <20060629201746.GA32142@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629201746.GA32142@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

> - constify and optimize stat_nam (thanks to Michael Tokarev!)
> - spelling and comment fixes
> 
> Run-tested on 2.6.17-mm4.
> 
> Signed-off-by: Andreas Mohr <andi@lisas.de>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
