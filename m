Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUIGOZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUIGOZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUIGOZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:25:00 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:62558 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268095AbUIGOY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:24:57 -0400
Subject: Re: 2.6.9-rc1-mm4
From: Kasper Sandberg <lkml@metanurb.dk>
To: Terje Kvernes <terjekv@math.uio.no>
Cc: Andrew Morton <akpm@osdl.org>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <wxxoekil26x.fsf@nommo.uio.no>
References: <20040907020831.62390588.akpm@osdl.org>
	 <wxxoekil26x.fsf@nommo.uio.no>
Content-Type: text/plain
Date: Tue, 07 Sep 2004 16:24:56 +0200
Message-Id: <1094567096.11870.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you feel like it, you are welcome to make the patch, atleast for me,
then ill test it :D

On Tue, 2004-09-07 at 13:59 +0200, Terje Kvernes wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
> > 
> > - Added Dave Howells' mysterious CacheFS.
> > - Various new fixes, cleanups and bugs, as usual.
> 
>   the sk98lin driver in the kernel is getting to be rather old, and
>   doesn't support things like the Marvel 88E8053 found on Asus P5AD2
>   Deluxe motherboards.  the installation tool from SysKonnect comes
>   with a patch generator, which makes everything nice and tidy, but
>   the patch is huge against any current kernel.  against 2.6.9-rc1-mm4
>   we're looking at just over a megabyte.
> 
>   I have however tested the driver against a few chipsets with 2.6.7
>   and 2.6.9-rc1-mm4, and it seems to work for me[tm].  I can happily
>   produce the patch for either of these kernels if need be.
> 
>   oh, and the version of the driver I've tested, version 7.07, finally
>   works with tools like pcimodules.
>  
> 

