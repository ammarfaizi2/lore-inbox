Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTDWTiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTDWTiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:38:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9221 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263582AbTDWThp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:37:45 -0400
Date: Wed, 23 Apr 2003 15:44:17 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1 - unresolved
In-Reply-To: <200304220915.56757.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.3.96.1030423154302.4451G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Marc-Christian Petersen wrote:

> On Tuesday 22 April 2003 01:39, Eyal Lebedinsky wrote:

> > /lib/modules/2.4.21-rc1/kernel/drivers/net/fc/iph5526.o
> > depmod:         fc_type_trans
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.21-rc1/kernel/drivers/net/wan/comx.o
> > depmod:         proc_get_inode
> well, I've posted a patch(fix) for all of these some weeks ago. If Marcelo's 
> focus is on something else ... bla.
> 
> Search the archives. I won't post it again and again and again and again 
> ^again^10.

It's nice that you posted it, did you try sending it to someone who puts
things in the kernel?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

