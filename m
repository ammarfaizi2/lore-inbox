Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVGJS3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVGJS3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVGJS1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:27:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31710 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262021AbVGJS0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:26:42 -0400
Date: Sun, 10 Jul 2005 20:26:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
Message-ID: <20050710182612.GA1776@elte.hu>
References: <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org> <20050707104859.GD22422@elte.hu> <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org> <20050708080359.GA32001@elte.hu> <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org> <1120944243.12169.3.camel@twins> <1120994288.14680.0.camel@twins> <20050710151008.GA28194@elte.hu> <1121010236.14680.6.camel@twins> <1121011953.14580.0.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121011953.14580.0.camel@twins>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Sun, 2005-07-10 at 17:43 +0200, Peter Zijlstra wrote:
> 
> > > I've also 
> > > released the -51-23 patch with these changes included. Does this fix 
> > > priority leakage on your SMP system?
> > > 
> > 
> > -51-24 right? I'll give it a spin.
> > 
> 
> a quick test seems to indicate it is indeed solved.

great!

	Ingo
