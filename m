Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVAUMsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVAUMsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVAUMsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:48:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262355AbVAUMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:48:10 -0500
Date: Fri, 21 Jan 2005 13:48:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
Message-ID: <20050121124807.GM3209@stusta.de>
References: <20050119213818.55b14bb0.akpm@osdl.org> <41F0B807.6000606@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F0B807.6000606@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 07:06:31PM +1100, Con Kolivas wrote:
> 
> Wont boot.
> 
> Stops after BIOS check successful.
> Tried reverting a couple of patches mentioning boot or reboot and had no 
> luck. Any ideas?
>...

Known bug that came from Linus' tree, already fixed in Linus' tree.

The thread discussion this bug starts with
  http://www.ussg.iu.edu/hypermail/linux/kernel/0501.2/1132.html

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

