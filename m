Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVDAQ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVDAQ26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVDAQ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:28:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46234 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262776AbVDAQ2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:28:55 -0500
Date: Fri, 1 Apr 2005 18:28:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050401162843.GA9309@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <55598.195.245.190.93.1112357613.squirrel@www.rncbc.org> <20050401125219.GA2560@elte.hu> <8294.195.245.190.93.1112366538.squirrel@www.rncbc.org> <20050401150620.GA6618@elte.hu> <46028.195.245.190.93.1112370726.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46028.195.245.190.93.1112370726.squirrel@www.rncbc.org>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> >> needs unknown symbol __compat_down_failed_interruptible
> 
> Nope. Same error output as last report.

does -43-04 work for you?

	Ingo
