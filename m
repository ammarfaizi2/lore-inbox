Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbVKWW6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVKWW6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbVKWW6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:58:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23827 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030472AbVKWW6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:58:47 -0500
Date: Wed, 23 Nov 2005 23:58:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/hfsplus/: move the hfsplus_inode_check() prototype to hfsplus_fs.h
Message-ID: <20051123225845.GK3963@stusta.de>
References: <20051123223508.GG3963@stusta.de> <Pine.LNX.4.58.0511231449120.20189@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511231449120.20189@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 02:50:05PM -0800, Randy.Dunlap wrote:
> On Wed, 23 Nov 2005, Adrian Bunk wrote:
> 
> > Function prototypes belong into header files.
> 
> I'd like to see someone fix kernel/power/disk.c also....

This will also be done before I'll submit my patch to add 
-Wmissing-prototypes to the global CFLAGS - but I can't fix all places 
in the kernel at the same day, there are too many of them...

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

