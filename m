Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946656AbWKJN7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946656AbWKJN7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946670AbWKJN7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:59:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21675 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946656AbWKJN7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:59:31 -0500
Date: Fri, 10 Nov 2006 14:58:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <20061110135855.GA6121@elte.hu>
References: <Pine.LNX.4.64.0610011336040.29459@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610011336040.29459@frodo.shire>
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


* Esben Nielsen <nielsen.esben@googlemail.com> wrote:

> Hi,
>  I finally got around to merge my patches into a newer -rt kernel and 
>  repost them.

ok - your patches look rather clean. I'll try to put them into the 
2.6.19 based -rt queue that i'm working on and see what happens.

	Ingo
