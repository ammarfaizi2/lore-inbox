Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbTIGV4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbTIGV4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:56:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39402 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261604AbTIGV4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:56:42 -0400
Date: Sun, 7 Sep 2003 23:56:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org, robert@schwebel.de,
       rusty@rustcorp.com.au
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907215634.GE27930@fs.tum.de>
References: <200309072146.h87LkwWU020877@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309072146.h87LkwWU020877@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 11:46:58PM +0200, Mikael Pettersson wrote:
>...
> Admittedly, the kernel could include some more performance-tweaking
> CONFIG options (mainly for L1 cache size and gcc -mcpu= values),
> but that's a simple thing to add if necessary.

-march implies -mcpu.

> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

