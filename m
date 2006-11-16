Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424433AbWKPURt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424433AbWKPURt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424434AbWKPURt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:17:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51109 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1424433AbWKPURt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:17:49 -0500
Date: Thu, 16 Nov 2006 21:16:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061116201657.GA32043@elte.hu>
References: <20061116153553.GA12583@elte.hu> <1163694712.26026.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163694712.26026.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0893]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > -rt0 is a rebase of -rt to 2.6.19-rc6, with lots of updates and 
> > fixes included. It includes the latest -hrt-dynticks tree and more.
> 
> Does the zero carry and meaning or did you just decide start using 
> zero instead of one?

no real meaning other than zero better signals the first -rc port's 
relative freshness.

	Ingo
