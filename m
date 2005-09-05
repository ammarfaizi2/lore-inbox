Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVIEBlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVIEBlz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 21:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVIEBlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 21:41:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24595 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932147AbVIEBlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 21:41:55 -0400
Date: Mon, 5 Sep 2005 03:41:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050905014153.GD3741@stusta.de>
References: <20050905013030.14361.qmail@web50211.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905013030.14361.qmail@web50211.mail.yahoo.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 06:30:29PM -0700, Alex Davis wrote:
> >The NdisWrapper FAQ already tells you that you need a patch for some of 
> >the binary-only Windows drivers that require more than 8kB stacks.
> >
> >And the fact that NdisWrapper is mostly working hinders the development 
> >of open source drivers for this hardware.
> 
> If the hardware manufacturer won't give you the spec's then writing a driver
> is going to be pretty difficult, if not impossible. Reverse-engineering 
> may be possible, but still....
> 
> I believe it's the lack of spec's, rather than the existence of ndiswrapper
> and driverloader, that hinder driver development. 

How do you put pressure on hardware manufacturers for getting them to 
release the specs?

If they are able to write "supported by Linux" on their products anyway 
because there's a driver that runs under NdisWrapper?

Or if people return/don't buy the hardware because of missing Linux 
support reducing the revenue of the hardware manufacturer by some $$ ?

> -Alex

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

