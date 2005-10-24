Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVJXPnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVJXPnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVJXPnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:43:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36359 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751111AbVJXPnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:43:46 -0400
Date: Mon, 24 Oct 2005 17:43:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051024154342.GA24527@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130168434.6831.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130168434.6831.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 08:40:34AM -0700, Badari Pulavarty wrote:
> On Mon, 2005-10-24 at 01:48 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> 
> Compile problems. 
> 
> Thanks,
> Badari
> 
> elm3b29:/usr/src/linux-2.6.14-rc5 # make -j40 modules
>   CHK     include/linux/version.h
>   CC [M]  drivers/serial/jsm/jsm_tty.o
> drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
> drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named
> `flip'
>...

Quoting Andrew's announcement:

   - A number of tty drivers still won't compile.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

