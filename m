Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUBTU0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUBTUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:22:51 -0500
Received: from quechua.inka.de ([193.197.184.2]:38545 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261331AbUBTUS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:18:29 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [Patch 2/6] dm: remove v1 ioctl interface
Date: Fri, 20 Feb 2004 21:18:21 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.02.20.20.18.20.737557@dungeon.inka.de>
References: <20040220153145.GN27549@reti> <20040220153436.GP27549@reti>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 15:47:33 +0000, Joe Thornber wrote:

> Remove the version-1 ioctl interface.
> 
> --- diff/drivers/md/dm-ioctl.c	2003-08-20 14:16:09.000000000 +0100
> +++ source/drivers/md/dm-ioctl.c	2004-02-18 15:23:23.000000000 +0000
> @@ -1,13 +1,1264 @@
>  /*
> - * Copyright (C) 2003 Sistina Software (UK) Limited.
> + * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.

new code, old copyright?


Andreas

