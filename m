Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSKKIDh>; Mon, 11 Nov 2002 03:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265664AbSKKIDg>; Mon, 11 Nov 2002 03:03:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43477 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265661AbSKKIDg>; Mon, 11 Nov 2002 03:03:36 -0500
Date: Mon, 11 Nov 2002 09:10:20 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: sfbest@us.ibm.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.47
Message-ID: <20021111081019.GD23116@fs.tum.de>
References: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 07:46:06PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.46 to v2.5.47
> ============================================
>...
> <sfbest@us.ibm.com>:
>   o add missing jfs_acl.h
>...

The corresponding .c file is still missing:

<--  snip  -->

...
make[2]: *** No rule to make target `fs/jfs/acl.o', needed by
`fs/jfs/jfs.o'.  Stop.
make[1]: *** [fs/jfs] Error 2

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

