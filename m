Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268749AbUHUAbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268749AbUHUAbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 20:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268711AbUHUAbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 20:31:38 -0400
Received: from 251041.vserver.de ([62.75.251.41]:61583 "EHLO 251041.vserver.de")
	by vger.kernel.org with ESMTP id S268748AbUHUAbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 20:31:08 -0400
Date: Fri, 20 Aug 2004 18:29:37 -0600
From: martin rumori <lists@rumori.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jackit-devel] Re: problems with volunteer preempt patch WAS: little NPTL SCHED_FIFO test program
Message-ID: <20040821002936.GA9453@amadora.tejo>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lee Revell <rlrevell@joe-job.com>,
	jackit-devel <jackit-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200408180100.04955.pnambic@unu.nu> <20040818023546.03e79fc4@mango.fruits.de> <1092794828.813.49.camel@krustophenia.net> <20040818050708.54a27a7e@mango.fruits.de> <pan.2004.08.19.23.33.47.308243@gmx.de> <1092987523.10063.62.camel@krustophenia.net> <20040820092042.GA2496@amadora.tejo> <1092994979.10063.80.camel@krustophenia.net> <20040820175351.GA2302@amadora.tejo> <20040820183559.GD21956@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820183559.GD21956@elte.hu>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 08:35:59PM +0200, Ingo Molnar wrote:
> * martin rumori <lists@rumori.de> wrote:
> > Checking if processor honors the WP bit even in supervisor mode... ok.
> > 
> > that's it.  freezes for 1-2 seconds after this last message, then
> > reboots.  tried to write down these contents of the screen, as far as
> > i could recognize them during the short period of time.

works now with -P6 and apm support in the kernel.  great.  thanks a
lot.

bests,

martin
