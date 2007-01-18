Return-Path: <linux-kernel-owner+w=401wt.eu-S1751331AbXARKVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXARKVE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbXARKVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:21:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47337 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbXARKVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:21:00 -0500
Date: Thu, 18 Jan 2007 11:19:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sunil Naidu <akula2.shark@gmail.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Realtime-preemption for 2.6.20-rc5 ?
Message-ID: <20070118101949.GA22671@elte.hu>
References: <8355959a0701180215s7824cea5m20a5d7b95d80c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0701180215s7824cea5m20a5d7b95d80c0e@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.3 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sunil Naidu <akula2.shark@gmail.com> wrote:

> Hi Ingo,
> 
> I would like to try with patch-2.6.20-rc5-rt7 for an experiment to 
> measure the latency. Is there any documentation or help which talks 
> about patching, issues, and latency benchmarks?

the best place to start is:

  http://rt.wiki.kernel.org

	Ingo
