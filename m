Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUHaXBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUHaXBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUHaW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:59:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44528 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268527AbUHaW4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:56:43 -0400
Date: Wed, 1 Sep 2004 00:56:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pedro_m@yahoo.com
Subject: Re: [patch] update email address of Pedro Roque Marques (fwd)
Message-ID: <20040831225634.GZ3466@fs.tum.de>
References: <20040831221353.GX3466@fs.tum.de> <20040831153853.7a40c6cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831153853.7a40c6cb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 03:38:53PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > The patch below (already ACK'ed by Pedro Roque Marques) updates his 
> > email address.
> 
> Sigh.  People move all the time.  Methinks it would be better to just put
> your name into the .c files and force people to consult MAINTAINERS/CREDITS
> to find the email address.

I have no strong opinion on this issue.

All I dislike are email addresses that bounce when sending a Cc of a 
patch.

But how do you plan to handle the email addresses in MODULE_AUTHOR?
Most people who see them don't have a MAINTAINERS/CREDITS on their 
computer (the same is true for email addresses in printk's).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

