Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbVBEONh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbVBEONh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbVBEONe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:13:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62220 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268380AbVBEON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:13:28 -0500
Date: Sat, 5 Feb 2005 15:13:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/char/tpqic02.c
Message-ID: <20050205141326.GF3129@stusta.de>
References: <20050205114047.GA3129@stusta.de> <200502051508.18813.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502051508.18813.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 03:08:18PM +0100, Oliver Neukum wrote:
> Am Samstag, 5. Februar 2005 12:40 schrieb Adrian Bunk:
> > Since at about half a year, this driver was no longer selectable via
> > Kconfig.
> 
> What happened when you ran oldconfig with a .config that had it set?

CONFIG_QIC02_TAPE is not set in the new .config .

oldconfig only uses the old .config to answer Kconfig questions that 
are actually asked.

> 	Regards
> 		Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

