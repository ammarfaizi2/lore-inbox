Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbULPXMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbULPXMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbULPXMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:12:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3849 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262054AbULPXKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:10:15 -0500
Date: Fri, 17 Dec 2004 00:10:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: james4765@verizon.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] computone: remove unnecessary files from drivers/char/ip2
Message-ID: <20041216231007.GW12937@stusta.de>
References: <20041216225431.4074.80006.90928@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216225431.4074.80006.90928@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 04:54:10PM -0600, james4765@verizon.net wrote:

> Let me try that one again - this time with the right file (oops :)
> 
> Remove a makefile and three programs from drivers/char/ip2 - they should not be in the kernel.
>...

Why did I think I've seen such a patch before?  ;-)

I sent the same patch some time ago and it's already in -mm.

You better send patches against -mm which is already over 17 MB away 
from -rc3.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

