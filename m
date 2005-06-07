Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVFGLfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVFGLfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVFGLfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:35:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48769 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261841AbVFGLew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:34:52 -0400
Date: Tue, 7 Jun 2005 13:34:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
Message-ID: <20050607113414.GA20640@elte.hu>
References: <20050607110409.GA14613@elte.hu> <1118143916.4533.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118143916.4533.24.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2005-06-07 at 13:04 +0200, Ingo Molnar wrote:
> > i have released the -V0.7.47-20 Real-Time Preemption patch, which can be 
> > downloaded from the usual place:
> > 
> 
> Ingo,
> 
> Here's the MAX_USER_RT_PRIO patch against your kernel.

thanks - i've added it to my tree and have uploaded the -47-23 patch. 

	Ingo
