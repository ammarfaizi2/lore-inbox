Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUJETqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUJETqd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUJETq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:46:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15336 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265773AbUJETne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:43:34 -0400
Date: Tue, 5 Oct 2004 21:44:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Message-ID: <20041005194458.GA15629@elte.hu>
References: <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <32799.192.168.1.5.1096994246.squirrel@192.168.1.5> <20041005184226.GA10318@elte.hu> <32787.192.168.1.5.1097005084.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32787.192.168.1.5.1097005084.squirrel@192.168.1.5>
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

> OTOH, I've tested T1 with CONFIG_SCHED_SMT and/or CONFIG_SMP not set,
> and got similar crashes too. So this seems to be some nasty bug
> introduced by -mm{1,2}, not by VP on SMP/SMT.
> 
> Yes, I do have some critical USB devices around here. One is that
> wacom tablet (mouse) and the other is a tascam us-224 audio/midi
> control surface that a love very much :)
> 
> Don't know if this makes me feeling better, doh.

i believe Andrew said that these USB problems should be fixed in the 
next -mm iteration.

	Ingo
