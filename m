Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTDVHGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTDVHGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 03:06:06 -0400
Received: from [80.190.48.67] ([80.190.48.67]:44548 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262961AbTDVHGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 03:06:06 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc1 - unresolved
Date: Tue, 22 Apr 2003 09:15:56 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <3EA48145.70A5589@eyal.emu.id.au>
In-Reply-To: <3EA48145.70A5589@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304220915.56757.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 April 2003 01:39, Eyal Lebedinsky wrote:

Hi Eyal,

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc1/kernel/drivers/char/ipmi/ipmi_msghandler.o
> depmod:         panic_notifier_list
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc1/kernel/drivers/char/ipmi/ipmi_watchdog.o
> depmod:         panic_notifier_list
> depmod:         panic_timeout
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc1/kernel/drivers/net/fc/iph5526.o
> depmod:         fc_type_trans
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc1/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode
well, I've posted a patch(fix) for all of these some weeks ago. If Marcelo's 
focus is on something else ... bla.

Search the archives. I won't post it again and again and again and again 
^again^10.

ciao, Marc
