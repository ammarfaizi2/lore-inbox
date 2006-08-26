Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWHZMzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWHZMzM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 08:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHZMzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 08:55:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751319AbWHZMzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 08:55:10 -0400
Date: Sat, 26 Aug 2006 14:55:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.28
Message-ID: <20060826125509.GC4765@stusta.de>
References: <20060826003639.GA4765@stusta.de> <200608261300.30873.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608261300.30873.mb@bu3sch.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 01:00:30PM +0200, Michael Buesch wrote:
> On Saturday 26 August 2006 02:36, Adrian Bunk wrote:
> > Security fixes since 2.6.16.27:
> > - CVE-2006-2935: cdrom: fix bad cgc.buflen assignment
> > - CVE-2006-3745: Fix sctp privilege elevation
> > - CVE-2006-4093: powerpc: Clear HID0 attention enable on PPC970 at boot time
> > - CVE-2006-4145: Fix possible UDF deadlock and memory corruption
> > 
> > 
> > Location:
> > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
> > 
> > git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> > 
> > RSS feed of the git tree:
> > http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss
> 
> Why isn't there an incremental patch-2.6.16.27-28.bz2 available
> in ftp://ftp.kernel.org/pub/linux/kernel/v2.6/incr ?

Thanks for the note, I've added it now (it might take a few minutes 
until it's at the mirrors).

> Greetings Michael.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

