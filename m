Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319090AbSIDH5d>; Wed, 4 Sep 2002 03:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319093AbSIDH5d>; Wed, 4 Sep 2002 03:57:33 -0400
Received: from denise.shiny.it ([194.20.232.1]:56255 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S319090AbSIDH5d>;
	Wed, 4 Sep 2002 03:57:33 -0400
Message-ID: <XFMail.20020904100201.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200209031804.g83I4YXC017714@habitrail.home.fools-errant.com>
Date: Wed, 04 Sep 2002 10:02:01 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03-Sep-2002 Hacksaw wrote:
> I can certainly imagine a few different ways to have partition tables that 
> make more sense than the typical Wintel version.

Yes, I would like to name partitions. I'd like to tell the kernel
to boot from root partition "John" and to 
mount -t ext2 --part Lisa /mnt/bkup without the very annoying thing
of boot and mounts failures when I add/remove phisical devices. To
do this we need partition table parsing inside the kernel IMHO.


Bye.

