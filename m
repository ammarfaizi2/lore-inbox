Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVFLAZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVFLAZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVFLAZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 20:25:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34041 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261862AbVFLAZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 20:25:30 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: tglx@linutronix.de
Cc: Daniel Walker <dwalker@mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1118535737.13312.120.camel@tglx.tec.linutronix.de>
References: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
	 <1118510817.13312.88.camel@tglx.tec.linutronix.de>
	 <1118515236.9519.92.camel@sdietrich-xp.vilm.net>
	 <1118534842.13312.111.camel@tglx.tec.linutronix.de>
	 <1118535360.5593.180.camel@sdietrich-xp.vilm.net>
	 <1118535737.13312.120.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 17:24:14 -0700
Message-Id: <1118535855.5593.186.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 02:22 +0200, Thomas Gleixner wrote:
> On Sat, 2005-06-11 at 17:15 -0700, Sven-Thorsten Dietrich wrote:
> > On Sun, 2005-06-12 at 02:07 +0200, Thomas Gleixner wrote:
> > > > 
> > > > This is too complex to argue about here.
> > > 
> > > Whats too complex? Are you asserting that other people e.g. me, are too
> > > dumb to understand that ?
> > > 
> > 
> > No, I said HERE, not FOR YOU. 
> 
> So where do you suggest to discuss this ?

Thomas,

I think this is intense high-performance scheduling theory, that is
beyond the scope of what people need to have in their mailbox.

We can use ext-rt-dev@mvista.com if everyone agrees.

Its a public subscription list, let me know, and I'll dig up the
subscribe info.

Sven


