Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUKXIdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUKXIdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbUKXIdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:33:15 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:10881 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261297AbUKXIdL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:33:11 -0500
Date: Wed, 24 Nov 2004 09:33:07 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041124080710.GA20755@elte.hu>
Message-Id: <Pine.OSF.4.05.10411240932230.9066-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry. Is it allowed to send the patch as an attachment instead? That is
easier.

Esben


On Wed, 24 Nov 2004, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > --- linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c.orig  2004-11-23 20:18:28.000000000 +0100
> > +++ linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c       2004-11-23 20:41:57.742899751 +0100
> 
> fyi, i've manually applied this patch to my tree - it didnt apply
> cleanly because apparently your mailer turned tabs into spaces. I also
> fixed up the coding style to match that of the kernel's.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

