Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUJPMAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUJPMAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268709AbUJPMAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 08:00:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54441 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268707AbUJPMAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 08:00:38 -0400
Date: Sat, 16 Oct 2004 14:01:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016120155.GA6066@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net> <20041016103608.GA3548@elte.hu> <32787.192.168.1.5.1097924629.squirrel@192.168.1.5> <20041016111244.GA4808@elte.hu> <32789.192.168.1.5.1097927739.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32789.192.168.1.5.1097927739.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OOPS. I think I've made a terrible mistake. It seems that
> SMP+PREEMPT_REALTIME is NOT solved after all in my P4/HT box, even
> with PREEMPT_TIMING not set.

no problem, there are other types of bugs too reported by others that do
not seem to be related to the PREEMPT_TIMING problem.

	Ingo
