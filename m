Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVCaN3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVCaN3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCaN3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:29:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58291 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261438AbVCaN26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:28:58 -0500
Date: Thu, 31 Mar 2005 15:28:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050331132838.GA31296@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk> <1112212608.3691.147.camel@localhost.localdomain> <1112218750.3691.165.camel@localhost.localdomain> <20050331110330.GA24842@elte.hu> <1112272607.3691.225.camel@localhost.localdomain> <1112273931.3691.233.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112273931.3691.233.camel@localhost.localdomain>
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

> > I'll play around some more with this.
> 
> Oops!  Found a little bug. Ingo, see if this fixes it.

yeah, that was it. I've uploaded -42-02 with the fix included.

	Ingo
