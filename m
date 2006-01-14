Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWANRyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWANRyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWANRyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:54:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13064 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750736AbWANRyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:54:12 -0500
Date: Sat, 14 Jan 2006 18:54:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org,
       Nerijus Baliunas <nerijus@users.sourceforge.net>,
       Reuben Farrelly <reuben-lkml@reub.net>, dsd@gentoo.org
Subject: Re: why sk98lin driver is not up-to date ?
Message-ID: <20060114175411.GO29663@stusta.de>
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5> <200601120339.17071.chase.venters@clientec.com> <43C63361.103@reub.net> <20060112181844.D8EF9BAE5@mx.dtiltas.lt> <43C7C03B.7000305@gentoo.org> <43C93760.7040502@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C93760.7040502@t-online.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 06:39:44PM +0100, Harald Dunkel wrote:
> Daniel Drake wrote:
> > Nerijus Baliunas wrote:
> > 
> >> Which one is better and what is a difference between them? Which one
> >> will support Marvell Technology Group Ltd. 88E8050 Gigabit Ethernet
> >> Controller
> >> (rev 17)? skge in 2.6.14 does not support it.
> > 
> > 
> > skge supports Yukon
> > sky2 supports Yukon-2
> > 
> > 88E8050 is Yukon-2.
> > 
> 
> Probably you need some testers for sky2. The -mm kernel would be a
> little bit too experimental for me, but it seems to be in -git10.
> Does this mean that it might appear in 2.6.15.1, or do I have to
> wait for 2.6.16?

2.6.15-git10 will become 2.6.16.

There won't be new drivers added in 2.6.15.x.

> Regards
> 
> Harri

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

