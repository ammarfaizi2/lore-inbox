Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWFAKdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWFAKdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWFAKdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:33:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:15510 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965024AbWFAKdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:33:10 -0400
Date: Thu, 1 Jun 2006 12:33:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060601103315.GA1865@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447EBD46.7010607@reub.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Reuben Farrelly <reuben-lkml@reub.net> wrote:

> >A .config would be useful too.
> 
> Now up at 
> http://www.reub.net/files/kernel/configs/2.6.17-rc5-mm2-x86_64.confg

hm, i cannot reproduce the stack backtrace secondary crash with your 
config. Weird.

	Ingo
