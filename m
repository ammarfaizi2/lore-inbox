Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWBTQiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWBTQiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWBTQiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:38:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12041 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161011AbWBTQiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:38:18 -0500
Date: Mon, 20 Feb 2006 17:38:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Brian Marete <bgmarete@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ver_linux slightly broken (Re: Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko)
Message-ID: <20060220163816.GC4661@stusta.de>
References: <6dd519ae0602200504n7d89dcb9j4685f1f0939f9c53@mail.gmail.com> <20060220162049.GA8052@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220162049.GA8052@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 07:20:49PM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 20, 2006 at 01:04:24PM +0000, Brian Marete wrote:
> > Linux C Library        14 02:33 /lib/libc.so.6
> 
> Please, run
> 
> 	ldd /bin/sh
> and
> 	ls -l /lib/libc*
> 
> and post full output. ver_linux needs updating.

Your statement might be true, but I don't see this specific information 
being as relevant for debugging this Oops.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

