Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTIGNSA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTIGNSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:18:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57542 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263263AbTIGNR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:17:56 -0400
Date: Sun, 7 Sep 2003 15:17:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907131732.GU14436@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030907114647.GR14376@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907114647.GR14376@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 01:46:47PM +0200, Jan-Benedict Glaw wrote:
> On Sun, 2003-09-07 13:28:13 +0200, Adrian Bunk <bunk@fs.tum.de>
> wrote in message <20030907112813.GQ14436@fs.tum.de>:
> > There are two different needs:
> > 1. the installation kernel of a distribution should support all CPUs 
> >    this distribution supports (perhaps starting with the 386)
> 
> So far, no major distribution does support an i386. Basically, this has
> leaked in by some broken patch to libstdc++ which was not observed for a
> long time. To support i386, an additional emulator for additional i486
> needs to be compiled-in, too. I had a short try to port Debian's patch
> into 2.6.x, but it oopsed :-> If I get some time, I'll finish that.
> Before we have thie i486-emu-for-i386 in, i386 support in the kernel
> doesn't make *any* sense on it's own...
>...

This is not related to the issues my patch addresses.

If you want to read my mail with a s/386/486/g and the contents should 
still be valid.

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

