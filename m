Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTHBWfW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270441AbTHBWfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 18:35:22 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:25874 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270438AbTHBWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 18:35:18 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Subject: Re: [PATCH 2.4.22-pre10] Cleanup DRM menu and give it a submenu
Date: Sun, 3 Aug 2003 00:35:02 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
References: <200307312250.40474.m.c.p@wolk-project.de> <Pine.LNX.4.56.0308022242400.18619@ppg_penguin>
In-Reply-To: <Pine.LNX.4.56.0308022242400.18619@ppg_penguin>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308030034.36498.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 August 2003 23:46, Ken Moffat wrote:

Hi Ken,

>  Is this really worth doing ?  `make menuconfig' seems to hide the
> options nicely until you turn drm on, and more importantly the 2.4
> kernel modules aren't exactly useful with X-4.3 so they're becoming
> increasingly redundant.

I think it is usefull. The more stuff you've enabled in your config, the more 
it becomes unreadable/confusing/complex etc.

And DRM merge for full X4.3 DRI usage is pending for 2.4.23-pre1. It'y in my 
draftbox and waiting for 2.4.22 final :)

ciao, Marc

