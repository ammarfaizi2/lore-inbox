Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUAYBCd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUAYBCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:02:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18662 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262913AbUAYBCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:02:31 -0500
Date: Sun, 25 Jan 2004 02:02:28 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Eric <eric@cisu.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Message-ID: <20040125010228.GH6441@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401240011.36074.eric@cisu.net> <200401241639.23479.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401241639.23479.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 04:39:23PM -0600, Eric wrote:
> On Saturday 24 January 2004 00:11, Eric wrote:
> > On Friday 23 January 2004 22:53, Eric wrote:
> > > Hello.
> > > 	I am unable to boot with kernels greater than 2.6.1-mm3. I do not recall
> > > if mm3 booted or not, but I know for sure that mm4 and rc1-mm1 are broken
> > > for me. When I try to boot the selected kernel I see uncompressing
> > > kernel.....then booting kernel.
> >
> > Very sorry, here is the .config i MEANT to attach but got distracted.
> 
> Confirmed, the same problem when I recompiled and tried (just now)
> 
> 2.6.1-rc1-mm1
> 2.6.1-rc1-mm2
> 
> What changed? Why am I suddenly locked out of all newer kernel versions?
> I am using vanilla sources with nothing other than mm patches.

Please check exactly between which two kernel versions the problem 
first appeared.

Please send the .config of the last kernel that worked for you.

> Eric Bambach

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

