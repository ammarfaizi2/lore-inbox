Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSEHKvB>; Wed, 8 May 2002 06:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSEHKvA>; Wed, 8 May 2002 06:51:00 -0400
Received: from pool-151-201-225-99.pitt.east.verizon.net ([151.201.225.99]:30336
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S312973AbSEHKvA>; Wed, 8 May 2002 06:51:00 -0400
Date: Wed, 8 May 2002 06:51:19 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Thunder from the hill <thunder@ngforever.de>
Subject: Re: jfs_mount.o: weird gcc behavior
Message-ID: <20020508065119.A427@marta>
Mail-Followup-To: Kurt Wall <kwall>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thunder from the hill <thunder@ngforever.de>
In-Reply-To: <Pine.LNX.4.44.0205072253070.19544-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scribbling feverishly on May 07, Thunder from the hill managed to emit:
> Hi,
> 
> when compiling fs/jfs/jfs_mount.c, gcc 2.95.2 keeps issuing 
> "../../gcc/caller-save:657: Internal compiler error in function 
> insert_save_restore". Unfortunately I'm unable to compile myself another 
> version of gcc, hell knows why...

Might want to report it on the GCC list (gcc@gcc.gnu.org). 

Kurt
-- 
Why can't you be a non-conformist like everyone else?
