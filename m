Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVFKTFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFKTFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVFKTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:05:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18438 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261503AbVFKTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:05:18 -0400
Date: Sat, 11 Jun 2005 21:05:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
Message-ID: <20050611190515.GE3770@stusta.de>
References: <1118476111230@kroah.com> <11184761113499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11184761113499@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:48:31AM -0700, Greg KH wrote:
>...
> --- gregkh-2.6.orig/drivers/block/acsi_slm.c	2005-06-10 23:48:38.000000000 -0700
> +++ gregkh-2.6/drivers/block/acsi_slm.c	2005-06-10 23:48:51.000000000 -0700
> @@ -1,5 +1,3 @@
> -/*
> - * acsi_slm.c -- Device driver for the Atari SLM laser printer
>   *
>   * Copyright 1995 Roman Hodek <Roman.Hodek@informatik.uni-erlangen.de>
>   *
>...

This part of the patch seems to be an accident.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

