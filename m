Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVFHMAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVFHMAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVFHMAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:00:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35016 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262185AbVFHMA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:00:29 -0400
Date: Wed, 8 Jun 2005 13:59:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
Message-ID: <20050608115956.GA7652@elte.hu>
References: <20050607194119.GA11185@elte.hu> <20050608074254.GA13452@elte.hu> <20050608074847.GB13452@elte.hu> <200506080735.15530.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506080735.15530.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> I just built this one, with RT but without the statistical stuff 
> enabled.  While rc6 works fine with tvtime-0.99, this gives a no video 
> blue screen, audio ok.

could you check PREEMPT_DESKTOP too, with softirq/hardirq threading 
enabled/disabled?

	Ingo
