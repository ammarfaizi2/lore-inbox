Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313555AbSDUQZU>; Sun, 21 Apr 2002 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313556AbSDUQZT>; Sun, 21 Apr 2002 12:25:19 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35474 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313555AbSDUQZS>; Sun, 21 Apr 2002 12:25:18 -0400
Date: Sun, 21 Apr 2002 10:25:14 -0600
Message-Id: <200204211625.g3LGPEE19519@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK patches exported.
In-Reply-To: <31608.1019318609@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> For the benefit of the BK haters, or more to the point for my benefit to 
> shut up the occasional whinging I've heard about needing to use BK to get 
> at the very latest patches from Linus' tree...
> 
> 	http://www.kernel.org/~dwmw2/bk-2.5/
> 
> It should be updated every hour on the hour, and has the last week's
> worth of changesets exported as patches.

PLEASE STOP!!! Your hourly empty updates trigger the mirror system,
which in turn causes hundreds of mirror sites around the world to do
an rsync. It's very wasteful.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
