Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTHBVqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHBVqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:46:13 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:37261
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S270370AbTHBVqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:46:10 -0400
Date: Sat, 2 Aug 2003 22:46:09 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.22-pre10] Cleanup DRM menu and give it a submenu
In-Reply-To: <200307312250.40474.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.56.0308022242400.18619@ppg_penguin>
References: <200307312250.40474.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003, Marc-Christian Petersen wrote:

> Hi Marcelo,
>
> I've been getting complaints about the menu structure from the linux kernel
> config subsystem for a _long time_. Now let's clean up the DRM menu and give
> it a submenu. We are getting close that the menu will look more cleaner :)
>
> More cleanups for different menu's are following.
>
> Please apply for 2.4.22-pre10. Thank you :)
>
> ciao, Marc
>

 Is this really worth doing ?  `make menuconfig' seems to hide the
options nicely until you turn drm on, and more importantly the 2.4
kernel modules aren't exactly useful with X-4.3 so they're becoming
increasingly redundant.

Ken
-- 




