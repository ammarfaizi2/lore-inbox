Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSE2Tmd>; Wed, 29 May 2002 15:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSE2Tmc>; Wed, 29 May 2002 15:42:32 -0400
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:58602 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id <S315440AbSE2Tmc>; Wed, 29 May 2002 15:42:32 -0400
Date: Wed, 29 May 2002 15:42:32 -0400
From: Jason Lunz <lunz@reflexsecurity.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.19
Message-ID: <20020529194232.GA1366@reflexsecurity.com>
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mlist.linux-kernel, you wrote:
> <kai@tp1.ruhr-uni-bochum.de>
> 	o kbuild: Figure out flags independently from pass
> 	o ISDN/CAPI: Move methods from capi_driver to capi_ctr
> 	o kbuild: Simplify rule for just building one subdir
> 	o kbuild: Use consistently FORCE instead of dummy
> 	o drivers/video/matrox/matroxfb_accel.c: Explicitly export symbols.
> 	o ISDN/CAPI: Cleanup /proc/capi
> 	o ISDN: CAPI: Remove unused capi_driver::driver_read_proc
> 	o ISDN/CAPI: Have hardware driver alloc struct capi_drv
> 	o ISDN/CAPI: Export callbacks for CAPI drivers directly
> 	o ISDN/CAPI: Remove struct capi_driver
> 	o kbuild: built-in and modules in one pass
> 	o kbuild: Normal sources should not include <linux/compile.h>
> 	o kbuild: Add EXTRA_TARGETS variable
> 	o kbuild: Remove remaining O_TARGET in drivers/*/Makefile
> 	o kbuild: Don't overwrite Rules.make's first_rule
> 	o kbuild: beautify Makefile / Rules.make...
> 	o kbuild: Group together descending/linking in drivers/*
> 	o kbuild: Build targets locally
> 	o kbuild: Provide correct 'make some/dir/file.[iso]'
> 	o kbuild: Hand merge link order change form driverfs update.

Are these purely patches to kbuild 1 or are they the beginning of a
gradual migration to kbuild 2?

-- 
Jason Lunz			Reflex Security
lunz@reflexsecurity.com		http://www.reflexsecurity.com/
