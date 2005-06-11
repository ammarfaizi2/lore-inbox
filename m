Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVFKTcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVFKTcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVFKTcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:32:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31494 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261781AbVFKTc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:32:28 -0400
Date: Sat, 11 Jun 2005 21:32:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Has anyone had problems with GCC 4.0 and the kernel?
Message-ID: <20050611193222.GI3770@stusta.de>
References: <200506092220.12973.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506092220.12973.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 10:20:12PM +0100, Nick Warne wrote:
> > The 2.4 kernels need fair amounts of patching,
> > 99% of which is to prevent compile-time errors. These patches
> > are not yet merged into the standard 2.4 tree and may never be.
> 
> So does this mean GCC 4.x is a no-go for people still using kernel 2.4.x?

AFAIR Mikael wanted to provide his patches for compiling kernel 2.4 with 
gcc 4.0 somewhere.

But they will most likely never go into into the official 2.4 kernel.

> Nick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

