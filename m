Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVEYLiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVEYLiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVEYLiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:38:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55481 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262218AbVEYLiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:38:13 -0400
Date: Wed, 25 May 2005 13:35:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050525113514.GA9145@elte.hu>
References: <20050523082637.GA15696@elte.hu> <42935890.2010109@cybsft.com> <20050525113424.GA1867@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525113424.GA1867@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> does it crash if you boot only with a single CPU (numcpus=1 boot 
> parameter)? If yes then could you send me that log, some of the more 
> interesting portions of the current log were garbled due to SMP 
> logging effects.

maxcpus=1 is the parameter.

	Ingo
