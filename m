Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVAPHZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVAPHZz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVAPHZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:25:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32781 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262442AbVAPHYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:24:42 -0500
Date: Sun, 16 Jan 2005 08:24:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       paulus@samba.org
Subject: Re: [PATCH] ppc64: Remove CONFIG_IRQ_ALL_CPUS
Message-ID: <20050116072439.GS4274@stusta.de>
References: <20050116043356.GM4274@stusta.de> <20050116051904.GP6309@krispykreme.ozlabs.ibm.com> <20050116055523.GQ6309@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116055523.GQ6309@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 04:55:23PM +1100, Anton Blanchard wrote:
>  
> Replace CONFIG_IRQ_ALL_CPUS with a boot option (noirqdistrib). Compile
> options arent much use on a distro kernel. This also removes the ppc64
> use of smp_threads_ready.
>...

Seems perfect for me.  :-)

I'll simply state that my patch depends on ppc64 on your patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

