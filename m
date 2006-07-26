Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWGZIWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWGZIWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWGZIWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:22:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59276 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030419AbWGZIWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:22:38 -0400
Date: Wed, 26 Jul 2006 10:16:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] reference rt-mutex-design in rtmutex.c
Message-ID: <20060726081631.GC11604@elte.hu>
References: <Pine.LNX.4.58.0607210942410.1190@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607210942410.1190@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> + *  Before making any design changes to this file, please refer to
> + *  Documentation/rt-mutex-design.txt and update accordingly.

please change this to:

 + * See Documentation/rt-mutex-design.txt for details.

	Ingo
