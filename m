Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVDAEoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVDAEoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVDAEoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:44:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51093 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262619AbVDAEnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:43:43 -0500
Date: Fri, 1 Apr 2005 06:43:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050401044307.GB22753@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk> <1112212608.3691.147.camel@localhost.localdomain> <1112218750.3691.165.camel@localhost.localdomain> <20050331110330.GA24842@elte.hu> <1112273378.3691.228.camel@localhost.localdomain> <20050331141040.GA2544@elte.hu> <1112290916.12543.19.camel@localhost.localdomain> <20050331174927.GA11483@elte.hu> <1112317173.28076.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112317173.28076.10.camel@localhost.localdomain>
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

> Hi Ingo,
> 
> I was wondering if the issue the bit_spin_lock has gone into the side 
> burner? [...]

could you send me your latest patch for the bit-spin issue? My main 
issue was cleanliness, so that the patch doesnt get stuck in the -RT 
tree forever.

	Ingo
