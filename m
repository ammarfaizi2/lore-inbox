Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbTLRNto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTLRNto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:49:44 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45553 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265140AbTLRNtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:49:43 -0500
Date: Thu, 18 Dec 2003 14:49:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux.nics@intel.com
Subject: Re: [BK PATCHES] 2.6.x experimental net driver updates
Message-ID: <20031218134937.GC12750@fs.tum.de>
References: <3FDEA6FA.4010906@pobox.com> <20031218013145.GG25717@fs.tum.de> <3FE1051B.3060104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE1051B.3060104@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 08:38:35PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >Hi Jeff,
> >
> >I got the following compile error when trying to compile e100 statically 
> >into a kernel using gcc 2.95:
> 
> 
> This is fixed in the updated patch:
> 
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp2.patch.bz2
> 
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp2.log

Thanks for the quick answer.

I can confirm that it's fxed now.

> Thanks,
> 
> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

