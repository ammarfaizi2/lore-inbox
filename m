Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUICHEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUICHEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269322AbUICHEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:04:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3017 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269261AbUICHDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:03:34 -0400
Date: Fri, 3 Sep 2004 09:05:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903070500.GB13100@elte.hu>
References: <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <1094162812.1347.54.camel@krustophenia.net> <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094194157.19760.71.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another question - any objections against me rebasing the VP patch to
the current -mm tree and keeping it there exclusively until all possible
merges are done? It would probably quite some work to create a complete
patch for the upstream or BK tree during that process, as small patches
start to flow in the VP => -mm => BK direction. Would any of the regular
VP users/testers be wary to use the -mm tree?

	Ingo
