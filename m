Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935193AbWK2GnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935193AbWK2GnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 01:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935211AbWK2GnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 01:43:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43242 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935193AbWK2GnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 01:43:11 -0500
Date: Wed, 29 Nov 2006 07:41:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hu Gang <linuxbest@gmail.com>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc6-rt8
Message-ID: <20061129064109.GA27932@elte.hu>
References: <20061127094927.GA7339@elte.hu> <20061129091825.5438cfb9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129091825.5438cfb9@localhost>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0321]
	0.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hu Gang <linuxbest@gmail.com> wrote:

> On Mon, 27 Nov 2006 10:49:27 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
> > the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> attached patch to making it compile and works in my PowerBook G4. 

thanks, applied. I'll let the PPC -rt folks sort out the hack effects. 
Do you have CONFIG_HIGH_RES_TIMERS enabled?

	Ingo
