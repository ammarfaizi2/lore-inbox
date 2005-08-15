Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVHOQAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVHOQAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVHOQAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:00:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61957 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964811AbVHOQAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:00:10 -0400
Date: Mon, 15 Aug 2005 18:00:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Feature removal: ACPI S4bios support
Message-ID: <20050815160007.GA3614@stusta.de>
References: <200508111417.47499.blaisorblade@yahoo.it> <20050812132444.GH1826@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812132444.GH1826@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 03:24:44PM +0200, Pavel Machek wrote:

> Remove S4BIOS support. It is pretty useless, and only ever worked for
> _me_ once. (I do not think anyone else ever tried it). It was in
> feature-removal for a long time, and it should have been removed before.
>...

You've forgotten to remove the feature-removal-schedule.txt entry in 
your patch.  ;-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

