Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932195AbWFDInB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWFDInB (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWFDInB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:43:01 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27034 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932195AbWFDInA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:43:00 -0400
Date: Sun, 4 Jun 2006 10:42:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, dwalker@mvista.com,
        James Perkins <james.perkins@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-rt]: Add missing headers to clocksource.h
Message-ID: <20060604084225.GB8418@elte.hu>
References: <20060601231010.GA21704@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601231010.GA21704@plexity.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5014]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Deepak Saxena <dsaxena@plexity.net> wrote:

> rt26 won't compile w/o this if GENERIC_TIME is set.

thanks, applied.

	Ingo
