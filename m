Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLWSEH>; Sat, 23 Dec 2000 13:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbQLWSD6>; Sat, 23 Dec 2000 13:03:58 -0500
Received: from www.wen-online.de ([212.223.88.39]:64016 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129410AbQLWSDk>;
	Sat, 23 Dec 2000 13:03:40 -0500
Date: Sat, 23 Dec 2000 18:33:03 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andreas Franck <afranck@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
In-Reply-To: <00122312341200.03033@dg1kfa.ampr.org>
Message-ID: <Pine.Linu.4.10.10012231826350.645-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Andreas Franck wrote:

> Hello,
> 
> I hope I am not doing something particularly stupid here, but as Linus
> encouraged curious people to try compiling the kernel with the
> latest gcc snapshots, I have tried - as several weeks before, but again
> in vain.
> 
> Since I have tried, the same following error on early boot (just after
> "Starting kswapd v1.8" appears on the screen) has bitten me, when I
> compiled the kernel with a recent gcc snapshot. This was for at least
> 2.4.0-test11 with gcc snapshots from 2 months ago till yesterday.

Hi,

I had the same, with the last few snapshots I tried, but 20001218 seems
to work ok.
dmesg|head -1
Linux version 2.4.0-test13ikd (root@el-kaboom) (gcc version gcc-2.97 20001218 (experimental)) #18 Sat Dec 23 17:43:29 CET 2000

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
