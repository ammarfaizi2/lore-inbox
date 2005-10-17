Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVJQPO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVJQPO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJQPO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:14:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:39589 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751392AbVJQPO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:14:57 -0400
Date: Mon, 17 Oct 2005 17:15:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] TASK_NONINTERACTIVE (was: Machine Freezes while Running Crossover Office)
Message-ID: <20051017151526.GA30113@elte.hu>
References: <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org> <courier.429C05C1.00005CC5@courier.cs.helsinki.fi> <20050601073544.GA21384@elte.hu> <1129561851.19040.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129561851.19040.2.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On Wed, 2005-06-01 at 09:35 +0200, Ingo Molnar wrote:
> > Pekka, could you check whether the patch below solves your Wine problem 
> > (without hurting interactivity otherwise)?
> 
> Any chance of getting this merged to the mainline? I am on 2.6.13.4 
> now and I still need to manually apply this patch to make Crossover 
> Office usable. I can confirm that it fixes the problem without 
> introducing any interactivity regressions as I have been running this 
> for the past four months or so.

it's upstream already, will be released in 2.6.14.

	Ingo
