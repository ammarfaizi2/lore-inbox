Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWADVBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWADVBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWADVBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:01:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750772AbWADVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:00:46 -0500
Date: Wed, 4 Jan 2006 22:00:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gcoady@gmail.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Message-ID: <20060104210045.GV3831@stusta.de>
References: <20060104145138.GN3831@stusta.de> <35dor152f8ehril7qh22oi8sgkjdohd9jv@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35dor152f8ehril7qh22oi8sgkjdohd9jv@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 07:53:00AM +1100, Grant Coady wrote:
> On Wed, 4 Jan 2006 15:51:38 +0100, Adrian Bunk <bunk@stusta.de> wrote:
>...
> > 	  If you say Y here the kernel will use a 4Kb stacksize for the
> > 	  kernel stack attached to each process/thread. This facilitates
> 
> Perhaps mention 4k + 4k stacks, the separate irq stacks used with 4k option?  

Feel free to submit a patch.  ;-)

> Grant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

