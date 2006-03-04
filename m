Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWCDRIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWCDRIM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCDRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:08:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64018 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751871AbWCDRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:08:11 -0500
Date: Sat, 4 Mar 2006 18:08:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.fr>, p_gortmaker@yahoo.com
Subject: Re: [PATCH 04/13] RTC subsystem, class
Message-ID: <20060304170810.GE9295@stusta.de>
References: <20060304164247.963655000@towertech.it> <20060304164248.740384000@towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304164248.740384000@towertech.it>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 05:42:51PM +0100, Alessandro Zummo wrote:
>...
> --- linux-rtc.orig/MAINTAINERS	2006-03-04 17:34:51.000000000 +0100
> +++ linux-rtc/MAINTAINERS	2006-03-04 17:34:54.000000000 +0100
> @@ -2193,6 +2193,12 @@ M:	p_gortmaker@yahoo.com
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  
> +REAL TIME CLOCK (RTC) SUBSYSTEM
> +P:	Alessandro Zummo
> +M:	a.zummo@towertech.it
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +
>...

The entry above the one you are adding is:

REAL TIME CLOCK DRIVER
P:      Paul Gortmaker
M:      p_gortmaker@yahoo.com
L:      linux-kernel@vger.kernel.org
S:      Maintained


Two entries for the same thing only cause confusion.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

