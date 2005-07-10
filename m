Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVGJQMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVGJQMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVGJQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 12:12:38 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:49704 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261900AbVGJQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 12:12:36 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1121010236.14680.6.camel@twins>
References: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
	 <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu>
	 <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
	 <20050707104859.GD22422@elte.hu>
	 <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
	 <20050708080359.GA32001@elte.hu>
	 <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org>
	 <1120944243.12169.3.camel@twins> <1120994288.14680.0.camel@twins>
	 <20050710151008.GA28194@elte.hu>  <1121010236.14680.6.camel@twins>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 18:12:33 +0200
Message-Id: <1121011953.14580.0.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-10 at 17:43 +0200, Peter Zijlstra wrote:

> > I've also 
> > released the -51-23 patch with these changes included. Does this fix 
> > priority leakage on your SMP system?
> > 
> 
> -51-24 right? I'll give it a spin.
> 

a quick test seems to indicate it is indeed solved.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

