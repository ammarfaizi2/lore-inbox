Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWGZMeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWGZMeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWGZMeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:34:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:14520 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751483AbWGZMeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:34:11 -0400
Date: Wed, 26 Jul 2006 14:27:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2] reference rt-mutex-design in rtmutex.c
Message-ID: <20060726122746.GA19885@elte.hu>
References: <Pine.LNX.4.58.0607210942410.1190@gandalf.stny.rr.com> <20060726081631.GC11604@elte.hu> <1153917047.6270.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153917047.6270.15.camel@localhost.localdomain>
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

> [V2 - update per Ingo's request]
> 
> In order to prevent Doc Rot, this patch adds a reference to the design
> document for rtmutex.c in rtmutex.c.  So when someone needs to update or
> change the design of that file they will know that a document actually
> exists that explains the design (helping them change it), and hopefully
> that they will update the document if they too change the design.
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
