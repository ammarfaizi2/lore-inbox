Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUBWRDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUBWRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:03:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60390 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261775AbUBWRDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:03:44 -0500
Date: Mon, 23 Feb 2004 18:03:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040223170336.GK5499@fs.tum.de>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 07:12:20PM -0800, Linus Torvalds wrote:
>...
> Actually, I'm a bit disgusted at Intel for not even _mentioning_ AMD in 
> their documentation or their releases, so I'd almost be inclined to rename 
> the thing as "AMD64" just to give credit where credit is due. However, 
> it's just not worth the pain and confusion.
>...

In the long term, x86_64 creates more confusion:
- SuSE says AMD64 [1]
- RedHat says AMD64 [2]
- Debian says AMD64 [3]

Renaming might be some work today, but it might actually remove 
confusion in the future.

> 		Linus

cu
Adrian

[1] http://www.suse.com/us/business/products/server/sles/amd64.html
[2] http://www.redhat.com/software/rhel/comparison/
[3] http://www.debian.org/ports/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

