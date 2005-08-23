Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVHWRV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVHWRV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVHWRV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:21:28 -0400
Received: from [62.206.217.67] ([62.206.217.67]:53683 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S1750905AbVHWRV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:21:27 -0400
Message-ID: <430B5B14.5070105@trash.net>
Date: Tue, 23 Aug 2005 19:21:24 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
In-Reply-To: <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> I think part of the problem is the continued
> misuse of the word "latency". Latency, in
> language terms, means "unexplained delay". Its
> wrong here because for one, its explainable. But
> it also depends on your perspective. The
> "latency" is increased for kernel tasks, while it
> may be reduced for something that is getting the
> benefit of preempting the kernel. So you really
> can't say "the price of reduced latency is lower
> throughput", because thats simply backwards.
> You've increased the kernel tasks latency by
> allowing it to be pre-empted. Reduced latency
> implies higher efficiency. All you've done here
> is shift the latency from one task to another, so
> there is no reduction overall, in fact there is
> probably a marginal increase due to the overhead
> of pre-emption vs doing nothing.

If instead of complaining you would provide the information
I've asked for two days ago someone might actually be able
to help you.
