Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVHEOIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVHEOIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVHEOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:08:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27147 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263029AbVHEOHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:07:52 -0400
Date: Fri, 5 Aug 2005 16:07:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Van Tuyl <gvtlinux@xmission.com>
Subject: Re: make modules Segfault
Message-ID: <20050805140748.GO4029@stusta.de>
References: <42F2E721.9020707@kegel.com> <Pine.LNX.4.61.0508050822460.20623@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508050822460.20623@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 08:23:18AM +0200, Jan Engelhardt wrote:
> 
> >> Gnu C                  2.96
> >
> > Seriously, it seems like your machine is flaky.
> > And even if it were a kernel source problem,
> > gcc should never have an internal error.
> > But gcc-2.96 is so old that it's not supported anymore.
> 
> Wasnot 2.96 the bugged one?

It was never an official gcc release, but it's an officially supported 
compiler for the kernel (see Documentation/Changes for details).

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

