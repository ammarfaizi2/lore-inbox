Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWANWTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWANWTr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWANWTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:19:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63753 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751328AbWANWTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:19:47 -0500
Date: Sat, 14 Jan 2006 23:19:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Scott H Kilau <Scott_Kilau@digi.com>,
       Wendy Xiong <wendyx@us.ltcfwd.linux.ibm.com>
Subject: Re: jsm serial driver broken with flip buffer changes
Message-ID: <20060114221947.GT29663@stusta.de>
References: <Pine.SOC.4.61.0601142359120.15808@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0601142359120.15808@math.ut.ee>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 12:02:59AM +0200, Meelis Roos wrote:
> In current 1.6.15+git jsm serial driver is broken:
> 
>   CC [M]  drivers/serial/jsm/jsm_tty.o
> drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
> drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named 
> `flip'
>...

Don't say "no" at
  Code maturity level options
    Prompt for development and/or incomplete code/drivers
      Select only drivers expected to compile cleanly

> Meelis Roos (mroos@linux.ee)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

