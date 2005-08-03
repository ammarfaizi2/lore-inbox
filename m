Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVHCOM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVHCOM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVHCOM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:12:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63245 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262168AbVHCOM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:12:28 -0400
Date: Wed, 3 Aug 2005 16:12:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Horms <horms@debian.org>
Cc: Frans Pop <aragorn@tiscali.nl>, 320379@bugs.debian.org,
       rgooch@atnf.csiro.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#320379: Errors during initrd loading when / is on LVM over RAID
Message-ID: <20050803141225.GP4029@stusta.de>
References: <200507290041.49606.aragorn@tiscali.nl> <20050803115432.GT23916@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803115432.GT23916@verge.net.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 08:54:37PM +0900, Horms wrote:
>...
> Hi Frans,
> 
> The null devfs_name check seems fine to me,
> I've CCed Richard Gooch for comment, hopefully
> he can offer one despite devfs being debricated
> upstream.
>...

The DEVFS_FS config option is no longer available in 2.6.13 making any 
fixes to devfs pointless.
 
> Horms

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

