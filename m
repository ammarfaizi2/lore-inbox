Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVFWODW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVFWODW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVFWODW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:03:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3083 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262511AbVFWODS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:03:18 -0400
Date: Thu, 23 Jun 2005 16:03:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@muc.de>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050623140316.GH3749@stusta.de>
References: <20050623142335.A5564@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623142335.A5564@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
>...
> However, wouldn't it be a good idea if this file was ordered by "when" ?
> A quick scan of the file reveals a couple of overdue/forgotten items
> (maybe they happened but the entry in the file got missed?):
>...
> What:   register_ioctl32_conversion() / unregister_ioctl32_conversion()
> When:   April 2005
>...

The removal (including the removal of the feature-removal-schedule.txt 
entry) is already in -mm.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

