Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280027AbRK2StP>; Thu, 29 Nov 2001 13:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283384AbRK2StC>; Thu, 29 Nov 2001 13:49:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5869 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283390AbRK2SsZ>;
	Thu, 29 Nov 2001 13:48:25 -0500
Date: Thu, 29 Nov 2001 19:45:56 +0100
From: Dirk Pritsch <dirk@enterprise.in-berlin.de>
To: Slo Mo Snail <slomosnail@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.5.1-pre3 in ide-scsi module
Message-ID: <20011129194556.B1402@Enterprise.in-berlin.de>
In-Reply-To: <20011129191938.A1402@Enterprise.in-berlin.de> <200111291838.fATIcHNO029528@einhorn.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111291838.fATIcHNO029528@einhorn.in-berlin.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 29, 2001 at 07:38:25PM +0100, Slo Mo Snail wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> Have you applied any other patches than the 2.5.1-pre3?
> If/When not you'll probably get some data corruption :(
> Please apply the 2 Patches attatched and
> http://kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre3/bio-pre3-1.gz
> Then recompile your kernel ;)
> These patches were posted before by Alan Cox and Jens Axboe
> 
> CD burning works fine for me with this patches but I have compiled all SCSI 
> and IDE stuff directly into the kernel... maybe this matters
> Bye
> 

thanks for the info, the patch from Alan was applied, but not the one
from Jens, I will try it again with both patches.


Cheers,

Dirk

