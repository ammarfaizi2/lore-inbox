Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbWEaXIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbWEaXIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWEaXIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:08:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41194 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965233AbWEaXI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:08:29 -0400
Date: Thu, 1 Jun 2006 01:08:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531230854.GA7912@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <4807377b0605310948h47c035f4q8f07a9c1a5bea993@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0605310948h47c035f4q8f07a9c1a5bea993@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5022]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

> On 5/30/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> >- Merged the runtime locking validator.  If you enable this your machine
> >  will run slowly.
> 
> The help in menuconfig mentions that a user looking for more info 
> should reference Documentation/locking-correctness.txt which doesn't 
> exist.

indeed - i'll fix this.

	Ingo
