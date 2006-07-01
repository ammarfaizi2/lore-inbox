Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWGAFhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWGAFhK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 01:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWGAFhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 01:37:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48061 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932381AbWGAFhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 01:37:08 -0400
Date: Sat, 1 Jul 2006 07:32:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060701053218.GA11195@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu> <20060630091850.GA10713@elte.hu> <20060630111734.GA22202@gondor.apana.org.au> <20060630113758.GA18504@elte.hu> <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com> <20060630203804.GA1950@elte.hu> <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
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


* Miles Lane <miles.lane@gmail.com> wrote:

> Okay, I rebuilt my kernel with your combo patch applied. Then, I 
> inserted my US Robotics USR2210 PCMCIA wifi card, ran "pccardutil 
> eject", popped out the card and then inserted a Compaq iPaq wifi card.  
> This triggered the following.

ok - but the ipv6 one went away, which is good. Will have a look at this 
new one.

	Ingo
