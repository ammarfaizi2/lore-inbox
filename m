Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263369AbVCJWqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbVCJWqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbVCJWnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:43:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30468 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262007AbVCJWcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:32:22 -0500
Date: Thu, 10 Mar 2005 23:32:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] kbuild updates
Message-ID: <20050310223218.GC3205@stusta.de>
References: <20050310215803.GA18044@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310215803.GA18044@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 10:58:04PM +0100, Sam Ravnborg wrote:
>...
> Full list below - the most important stuff:
>...
> o Use -Wno-pointer-sign for gcc 4.0
>...
> Except a few trivial things it has been in -mm for a while
> with no comments.

If this is the same version as in 2.6.11-mm2 (you didn't offer a GNU 
patch so that I could check it), the following is still present:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/1507.html

> 	Sam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

