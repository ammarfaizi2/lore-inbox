Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVEEPWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVEEPWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVEEPWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:22:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262130AbVEEPWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:22:48 -0400
Date: Thu, 5 May 2005 17:22:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm3
Message-ID: <20050505152247.GB3590@stusta.de>
References: <20050504221057.1e02a402.akpm@osdl.org> <200505051457.j45EvAm6013062@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505051457.j45EvAm6013062@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 10:57:10AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 04 May 2005 22:10:57 PDT, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> > 
> > - device mapper updates
> > 
> > - more UML updates
> > 
> > - -mm seems unusually stable at present.
> 
> Indeed.  Line counts for the announcement e-mails for the 2.6.12-rc*-mm*:
> 
> 2.6.12-rc1-mm1 2345
> 2.6.12-rc1-mm2 3048
> 2.6.12-rc1-mm3 2861
> 2.6.12-rc1-mm4 2612
> 2.6.12-rc2-mm1 2460
> 2.6.12-rc2-mm2 2610
> 2.6.12-rc2-mm3 2763
> 2.6.12-rc3-mm1 1236
> 2.6.12-rc3-mm2  105
> 2.6.12-rc3-mm3  796
> 
> (Presuming that the linecounts are at least roughly proportional to the
> churn in patches added/merged/dropped).
>...

Your presumption is only correct starting with 2.6.12-rc3-mm1, because 
since 2.6.12-rc3-mm1 the announcements do no longer contain the big 
detailed listing of all patches in -mm.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

