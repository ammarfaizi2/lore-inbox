Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGaKT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGaKT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbVGaKT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:19:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261667AbVGaKT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:19:27 -0400
Date: Sun, 31 Jul 2005 12:19:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
Message-ID: <20050731101923.GL5590@stusta.de>
References: <20050731020552.72623ad4.akpm@osdl.org> <6f6293f105073103045fd32d61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6293f105073103045fd32d61@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 12:04:59PM +0200, Felipe Alfaro Solana wrote:

> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
> 
> Why was the KERNEL_VERSION(a,b,c) macro removed from
> include/linux/version.h? The removal breaks external drivers like

It moved to a different header file.

> NDISWRAPPER or nVidia propietary.

That's their problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

