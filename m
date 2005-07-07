Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVGGTwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVGGTwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGGTtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:49:49 -0400
Received: from unused.mind.net ([69.9.134.98]:54684 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262028AbVGGTr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:47:26 -0400
Date: Thu, 7 Jul 2005 12:46:32 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-08
In-Reply-To: <20050707191854.GA32384@elte.hu>
Message-ID: <Pine.LNX.4.58.0507071233010.24968@echo.lysdexia.org>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507070120100.22287@echo.lysdexia.org>
 <20050707191854.GA32384@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Ingo Molnar wrote:

> > Without the last two chunks of this patch, the UP Athlon box locks up 
> > hard as soon as jackd is started up.
> 
> hm, do you have CONFIG_PCI_MSI enabled by any chance?

I've never enabled CONFIG_PCI_MSI.  What's your experience when it comes 
to stability and performance?

--ww
