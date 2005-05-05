Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVEEQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVEEQov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVEEQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:44:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4115 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262157AbVEEQoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:44:39 -0400
Date: Thu, 5 May 2005 18:44:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm3
Message-ID: <20050505164437.GC3590@stusta.de>
References: <20050504221057.1e02a402.akpm@osdl.org> <200505051457.j45EvAm6013062@turing-police.cc.vt.edu> <20050505152247.GB3590@stusta.de> <200505051549.j45FnBKE015372@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505051549.j45FnBKE015372@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 11:49:11AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 05 May 2005 17:22:47 +0200, Adrian Bunk said:
> 
> > Your presumption is only correct starting with 2.6.12-rc3-mm1, because 
> > since 2.6.12-rc3-mm1 the announcements do no longer contain the big 
> > detailed listing of all patches in -mm.
> 
> Note to self:  Ingest caffeine, *THEN* do statistics. :) I *thought* the
> last few -mm announces looked different, couldn't put my finger on what though ;)
> 
> OK.. Adding the number of 'All NNN patches' to the -rc3-mm*:
>...

Actually you'd have to add 3 x NNN to get a roughly correct number.

But then there's the question what you want to measure. Now you are 
measuring the amount of patches (that is already printed in the 
announcements). If you want to measure the amount of changes, you should 
better substract this from the older ones instead of adding it to the 
newer ones.

The next problem is that e.g. in BK times, Greg's trees were only a few 
lines of the announcement, while now every single patch in his trees is 
listed...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

