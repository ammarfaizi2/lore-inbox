Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423228AbWF1IwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423228AbWF1IwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423229AbWF1IwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:52:15 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:476 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423228AbWF1IwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:52:14 -0400
Date: Wed, 28 Jun 2006 10:47:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, tglx@linutronix.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
Message-ID: <20060628084723.GA14953@elte.hu>
References: <1151479204.25491.491.camel@localhost.localdomain> <20060628081345.GA12647@elte.hu> <20060628083008.GA14056@elte.hu> <20060628.013940.41192890.davem@davemloft.net> <20060628014807.0694436f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628014807.0694436f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > ok, sparc64 needed the rename fix below, but otherwise it built fine on 
> > > -mm3.
> > 
> > Thanks Ingo.
> > 
> > Can we get the genirq stuff into Linus's tree soon?
> 
> I'm thinking Thursday/Fridayish.  Is that OK?

fine with me. (Thursday would be slightly better i guess, from a 
dont-work-on-weekends-too-hard POV.)

	Ingo
