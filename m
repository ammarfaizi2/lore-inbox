Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263319AbVCEGRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbVCEGRS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVCEGNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:13:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7179 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263034AbVCDUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:41:23 -0500
Date: Fri, 4 Mar 2005 21:41:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mike@waychison.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] unexport complete_all
Message-ID: <20050304204120.GI3327@stusta.de>
References: <422817C3.2010307@waychison.com> <58cb370e0503040240314120ea@mail.gmail.com> <20050304110750.GD3992@stusta.de> <38620.66.11.176.22.1109956113.squirrel@webmail1.hrnoc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38620.66.11.176.22.1109956113.squirrel@webmail1.hrnoc.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:08:33PM -0500, mike@waychison.com wrote:
> 
> Did you just blindly grep the userspace tarball?
> 
> There is no kernel code in there.  It's all in linux-2.6.*-autofsng-*.patch.

Sorry, my bad.

I couldn't connect to your FTP server this morning (I don't know why) 
and I found the wrong file with Google.

This makes my patch void.

> Mike Waychison

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

