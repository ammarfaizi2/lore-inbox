Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbVKWXBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbVKWXBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbVKWXBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:01:53 -0500
Received: from xenotime.net ([66.160.160.81]:42725 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030469AbVKWXBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:01:52 -0500
Date: Wed, 23 Nov 2005 15:01:50 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/hfsplus/: move the hfsplus_inode_check() prototype
 to hfsplus_fs.h
In-Reply-To: <20051123225845.GK3963@stusta.de>
Message-ID: <Pine.LNX.4.58.0511231500470.20189@shark.he.net>
References: <20051123223508.GG3963@stusta.de> <Pine.LNX.4.58.0511231449120.20189@shark.he.net>
 <20051123225845.GK3963@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Adrian Bunk wrote:

> On Wed, Nov 23, 2005 at 02:50:05PM -0800, Randy.Dunlap wrote:
> > On Wed, 23 Nov 2005, Adrian Bunk wrote:
> >
> > > Function prototypes belong into header files.
> >
> > I'd like to see someone fix kernel/power/disk.c also....
>
> This will also be done before I'll submit my patch to add
> -Wmissing-prototypes to the global CFLAGS - but I can't fix all places
> in the kernel at the same day, there are too many of them...

Of course, I didn't expect them to be fixed in one day
or even for you to be the only person who may do it.

Thanks,
-- 
~Randy
