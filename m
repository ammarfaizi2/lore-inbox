Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271156AbTHCLjd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTHCLjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:39:31 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:15761
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S271156AbTHCLig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:38:36 -0400
Date: Sun, 3 Aug 2003 12:38:35 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.22-pre10] Cleanup DRM menu and give it a submenu
In-Reply-To: <200308030034.36498.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.56.0308031237250.20719@ppg_penguin>
References: <200307312250.40474.m.c.p@wolk-project.de>
 <Pine.LNX.4.56.0308022242400.18619@ppg_penguin> <200308030034.36498.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Marc-Christian Petersen wrote:

> On Saturday 02 August 2003 23:46, Ken Moffat wrote:
>
> Hi Ken,
>
> >  Is this really worth doing ?  `make menuconfig' seems to hide the
> > options nicely until you turn drm on, and more importantly the 2.4
> > kernel modules aren't exactly useful with X-4.3 so they're becoming
> > increasingly redundant.
>
> I think it is usefull. The more stuff you've enabled in your config, the more
> it becomes unreadable/confusing/complex etc.

 Ok, I guess I'm used to the complexity.
>
> And DRM merge for full X4.3 DRI usage is pending for 2.4.23-pre1. It'y in my
> draftbox and waiting for 2.4.22 final :)
>
> ciao, Marc
>

 Now that _is_ good news.

Ken
-- 



