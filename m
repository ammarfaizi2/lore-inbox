Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269701AbUICSR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269701AbUICSR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269718AbUICSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:14:40 -0400
Received: from mail3.utc.com ([192.249.46.192]:51137 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S269710AbUICSKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:10:16 -0400
Message-ID: <4138B33E.1050505@cybsft.com>
Date: Fri, 03 Sep 2004 13:09:02 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
References: <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <1094162812.1347.54.camel@krustophenia.net> <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu>
In-Reply-To: <20040903070500.GB13100@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> another question - any objections against me rebasing the VP patch to
> the current -mm tree and keeping it there exclusively until all possible
> merges are done? It would probably quite some work to create a complete
> patch for the upstream or BK tree during that process, as small patches
> start to flow in the VP => -mm => BK direction. Would any of the regular
> VP users/testers be wary to use the -mm tree?
> 
> 	Ingo
> 

I don't have any objections. Should I be wary of running the -mm tree?

kr
