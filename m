Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUG3XVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUG3XVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267868AbUG3XVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:21:55 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6404 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267869AbUG3XVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:21:54 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Shane Shrybman <shrybman@aei.ca>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091209106.2356.3.camel@mars>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
	 <1091209106.2356.3.camel@mars>
Content-Type: text/plain
Date: Sat, 31 Jul 2004 01:21:35 +0200
Message-Id: <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 13:38 -0400, Shane Shrybman wrote:

> > M5 does that differently, yes - so could you try it? If you still get
> > problems, does this fix it:
> 
> Ok, M5 locked up the whole machine within a few seconds of starting X.

Me too, with voluntary-preempt=3... It seems I can trigger this randomly
by heavily moving the mouse around while logging in into my KDE session.

However, with voluntary-preempt=2 I've been unable to lock the machine
yet.

