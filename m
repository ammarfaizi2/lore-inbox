Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVEWL01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEWL01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVEWL01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 07:26:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41900 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261232AbVEWL0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 07:26:21 -0400
Date: Mon, 23 May 2005 13:23:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050523112317.GA10579@elte.hu>
References: <20050523082637.GA15696@elte.hu> <1116840848.1498.4.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116840848.1498.4.camel@ibiza.btsn.frna.bull.fr>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Le lun 23/05/2005 à 10:26, Ingo Molnar a écrit :
> > i have released the -V0.7.47-06 Real-Time Preemption patch, which can be 
> > downloaded from the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> Cannot generate correctly for i686 :

i've uploaded -07, does it work now?

	Ingo
