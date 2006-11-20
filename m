Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933810AbWKTAlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933810AbWKTAlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933813AbWKTAlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:41:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1041 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933811AbWKTAlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:41:49 -0500
Date: Mon, 20 Nov 2006 01:41:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
Message-ID: <20061120004147.GC31879@stusta.de>
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 04:12:31PM -0800, Randy Dunlap wrote:
> make xconfig is segfaulting on me in 2.6.19-rc6 and later
> when I do ^F (find/search).
> Works fine in 2.6.19-rc5 and earlier.
> 
> The only message log I get is:
> 
> qconf[5839]: segfault at 0000000000000008 rip 00000000004289bc rsp 00007fffa08ccf10 error 4
> 
> I don't see any changes in scripts/kconfig/* in 2.6.19-rc6.
> Any ideas/suggestions?

Works fine for me in -rc6.

Did you upgrade Qt, or could there be any other local change that broke 
it for you?

> Thanks,
> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

