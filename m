Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWFUSdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWFUSdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWFUSdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:33:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1705 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751187AbWFUSdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:33:09 -0400
Date: Wed, 21 Jun 2006 20:28:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: tglx@timesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17-rt1 ommit an oops when suspending
Message-ID: <20060621182812.GA1693@elte.hu>
References: <200606211754.55059.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606211754.55059.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Hi
> 
> with this applied my AMD64 suspended resumed successfully in 
> PREEMPT_RT mode. Erm at least until now ;-) Takes longer than with 
> mainline.

thanks, applied.

	Ingo
