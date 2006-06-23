Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933019AbWFWLNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbWFWLNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933038AbWFWLNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:13:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32740 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933019AbWFWLNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:13:14 -0400
Date: Fri, 23 Jun 2006 13:08:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/lockdep.c: make 3 functions static
Message-ID: <20060623110813.GC10479@elte.hu>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060623105540.GN9111@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623105540.GN9111@stusta.de>
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


* Adrian Bunk <bunk@stusta.de> wrote:

> This patch makes three needlessly global functions static.

thanks, i've added this to my lock validator tree.

	Ingo
