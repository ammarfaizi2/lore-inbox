Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCaOLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCaOLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCaOLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:11:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40890 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261459AbVCaOLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:11:12 -0500
Date: Thu, 31 Mar 2005 16:10:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050331141040.GA2544@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk> <1112212608.3691.147.camel@localhost.localdomain> <1112218750.3691.165.camel@localhost.localdomain> <20050331110330.GA24842@elte.hu> <1112273378.3691.228.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112273378.3691.228.camel@localhost.localdomain>
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

> One more thing. Was this on SMP or UP.  I haven't tested this on SMP 
> yet. When my laptop (HT) gets done with its work, I'll give it a try 
> there. Of course I need to disable NVidia on it first.

i've booted the latest tree on a 4-way testbox and everything seems ok.

	Ingo
