Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWF2GrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWF2GrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWF2GrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:47:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3532 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932670AbWF2GrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:47:06 -0400
Date: Thu, 29 Jun 2006 08:42:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       tglx@linutronix.de, bunk@stusta.de, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
Message-ID: <20060629064213.GA26355@elte.hu>
References: <1151479204.25491.491.camel@localhost.localdomain> <20060628081345.GA12647@elte.hu> <20060628083008.GA14056@elte.hu> <20060628.013940.41192890.davem@davemloft.net> <20060628014807.0694436f.akpm@osdl.org> <17571.24072.340523.225237@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17571.24072.340523.225237@cargo.ozlabs.ibm.com>
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


* Paul Mackerras <paulus@samba.org> wrote:

> > I'm thinking Thursday/Fridayish.  Is that OK?
> 
> I'm not sure that leaves me time to get Ben H's powerpc genirq stuff 
> into the powerpc.git tree and get Linus to pull before the end of the 
> merge window...

The genirq changes on powerpc qualify as fixes i think - would that help 
the logistics of this merge?

	Ingo
