Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVFLO4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVFLO4X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVFLO4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:56:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58382 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262618AbVFLO4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:56:13 -0400
Date: Sun, 12 Jun 2005 16:56:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kjetil Kjernsmo <kjetil@kjernsmo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debian 2.6.8-16 kernel BUG at fs/jbd/checkpoint.c:618
Message-ID: <20050612145609.GP3770@stusta.de>
References: <200506121548.48084.kjetil@kjernsmo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506121548.48084.kjetil@kjernsmo.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 03:48:47PM +0200, Kjetil Kjernsmo wrote:

> Hi kernel-hackers!

Hi Kjetil!

> I've just had a scary experience, they are fortunately rare! :-)
> I'm running what is now Debian Stable, a self-compiled but unpatched 
> Debian 2.6.8-16 kernel.
>  
> The first symptom I saw was that Emacs segfaulted on me and while I was 
> pondering how scary _that_ was, the whole system froze on me. 
> Rebooting, I saw the following in kern.log. Since it shouts it is a 
> kernel bug, I took that as invitiation to post here. 
>...

Can you reproduce this problem with kernel 2.6.12-rc6?

If not, please report this problem to Debian instead of here.

> Cheers,
> 
> Kjetil

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

