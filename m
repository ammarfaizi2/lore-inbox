Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbREZW6z>; Sat, 26 May 2001 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbREZW6q>; Sat, 26 May 2001 18:58:46 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262033AbREZW6h>;
	Sat, 26 May 2001 18:58:37 -0400
Message-Id: <l03130301b735be2247ee@[208.179.166.40]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 26 May 2001 13:11:13 -0700
To: linux-kernel@vger.kernel.org
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Subject: Re: Linux 2.4.4-ac17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The OS resides on disk, yes.  I suppose I could plunk a minimal
> system into ramfs, pivot_root and umount disk, but I don't see
> any way that could matter for a memory leak.
>

It is very difficult to see memory leak , with hard disks .

As i told you , in my case i am using no harddisks , only thing i have is
RAM , so i am using only Ramdisk and ramfs, so in my case my Ram will full
within few minutes and My machine hangs .

Thanks ,

Jaswinder.
--
These are my opinions not 3Di.


