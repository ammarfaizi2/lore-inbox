Return-Path: <linux-kernel-owner+w=401wt.eu-S1030717AbWLPIAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030717AbWLPIAG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbWLPIAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:00:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36312 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030717AbWLPIAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:00:04 -0500
Date: Sat, 16 Dec 2006 08:58:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux@bohmer.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.19-rt14 does not compile with CONFIG_NO_HZ
Message-ID: <20061216075800.GB16116@elte.hu>
References: <3efb10970612150606p643f7cffr6b93e857843abed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efb10970612150606p643f7cffr6b93e857843abed6@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1633]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Remy Bohmer <l.pinguin@gmail.com> wrote:

> Hello,
> 
> For your Information, I get the following compile error when 
> CONFIG_NO_HZ is NOT configured on 2.6.19.1-rt14:

does -rt15 work any better?

	Ingo
