Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVBBOEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVBBOEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVBBOEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:04:40 -0500
Received: from alog0535.analogic.com ([208.224.223.72]:16000 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262374AbVBBOEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:04:22 -0500
Date: Wed, 2 Feb 2005 09:04:26 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Haakon Riiser <haakon.riiser@fys.uio.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
In-Reply-To: <20050202133108.GA2410@s>
Message-ID: <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
References: <20050202133108.GA2410@s>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Haakon Riiser wrote:

> How can I use a frame buffer driver's optimized copyarea, fillrect,
> blit, etc. from userspace?  The only way I've ever seen anyone use
> the frame buffer device is by mmap()ing it and doing everything
> manually in the mapped memory.  I assume there must be ioctls for
> accessing the accelerated functions, but after several hours of
> grepping and googling, I give up. :-(
>
> Any help is greatly appreciated!
>

X-Windows already does this. Execute `/usr/bin/X11/x11perf -all` to watch.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
