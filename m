Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936036AbWK2UFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936036AbWK2UFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936033AbWK2UFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:05:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50366 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936036AbWK2UFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:05:13 -0500
Date: Wed, 29 Nov 2006 21:03:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] 2.6.19-4c6-rt9 build problem
Message-ID: <20061129200307.GA11591@elte.hu>
References: <20061129194821.GA2895@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129194821.GA2895@us.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Hello!
> 
> Got a compiler error building 1.6.19-rc6-rt9 on NUMA-Q, admittedly 
> with unusual config.  The patch below solves it, though I cannot say 
> that I am an ACPI expert.

thanks, applied. Have you tried to boot the resulting kernel as well?

	Ingo
