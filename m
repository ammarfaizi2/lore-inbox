Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTDWTm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTDWTln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:41:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32488 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263629AbTDWTlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:41:18 -0400
Date: Wed, 23 Apr 2003 16:51:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1 - unresolved
In-Reply-To: <200304220915.56757.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.53L.0304231650300.7085@freak.distro.conectiva>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
 <3EA48145.70A5589@eyal.emu.id.au> <200304220915.56757.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Apr 2003, Marc-Christian Petersen wrote:

> On Tuesday 22 April 2003 01:39, Eyal Lebedinsky wrote:
>
> Hi Eyal,
>
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.21-rc1/kernel/drivers/char/ipmi/ipmi_msghandler.o
> > depmod:         panic_notifier_list
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.21-rc1/kernel/drivers/char/ipmi/ipmi_watchdog.o
> > depmod:         panic_notifier_list
> > depmod:         panic_timeout
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.21-rc1/kernel/drivers/net/fc/iph5526.o
> > depmod:         fc_type_trans
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.21-rc1/kernel/drivers/net/wan/comx.o
> > depmod:         proc_get_inode
> well, I've posted a patch(fix) for all of these some weeks ago. If Marcelo's
> focus is on something else ... bla.

I'm sorry for not having looked into it, Marc. My inbox is not a very
easily manageable thing.

> Search the archives. I won't post it again and again and again and again
> ^again^10.

I will look into the archives. Thank you.
