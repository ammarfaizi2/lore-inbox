Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWKLSKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWKLSKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWKLSKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:10:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20691 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751893AbWKLSKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:10:42 -0500
Date: Sun, 12 Nov 2006 19:09:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061112180953.GA3266@elte.hu>
References: <200611121753.kACHrDDi004283@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611121753.kACHrDDi004283@harpo.it.uu.se>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikael Pettersson <mikpe@it.uu.se> wrote:

> Sorry, no joy. The first access post-resume still fails and generates:

ok, then someone who knows the floppy driver better than me should put 
the right stuff into the suspend/resume hooks :-)

	Ingo
