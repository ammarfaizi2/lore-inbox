Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVCGIun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVCGIun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCGIun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:50:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33291 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261704AbVCGIuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:50:16 -0500
Date: Mon, 7 Mar 2005 09:50:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [BK PATCH] I2C patches for 2.6.11
Message-ID: <20050307085013.GD3170@stusta.de>
References: <20050304203531.GA31644@kroah.com> <20050305125902.71286764.khali@linux-fr.org> <20050306065555.GD14943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306065555.GD14943@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:55:55PM -0800, Greg KH wrote:
> On Sat, Mar 05, 2005 at 12:59:02PM +0100, Jean Delvare wrote:
> > Hi Greg,
> > 
> > > Here is a I2C update for 2.6.11.  It includes a number of fixes, and
> > > some new i2c drivers.  All of these patches have been in the past few
> > > -mm releases.
> > 
> > I checked against my own list of patches and found that I have two more,
> > which were posted to the sensors and kernel-janitors list in early
> > february:
> > http://archives.andrew.net.au/lm-sensors/msg29340.html
> > http://archives.andrew.net.au/lm-sensors/msg29342.html
> > 
> > They never made it to your own i2c tree, nor Andrew's tree. What do we
> > want to do with these?
> 
> They should show up in the -kj tree, right?  That will make it to the
> -mm tree, and then the kernel janitor maintainer will split them up and
> send them to me and you.
>...

-kj is not included in -mm.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

