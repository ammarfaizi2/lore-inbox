Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131167AbQLFUnP>; Wed, 6 Dec 2000 15:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbQLFUnF>; Wed, 6 Dec 2000 15:43:05 -0500
Received: from newaccess.hereintown.net ([207.196.96.3]:7459 "EHLO
	newaccess.hereintown.net") by vger.kernel.org with ESMTP
	id <S131179AbQLFUmr>; Wed, 6 Dec 2000 15:42:47 -0500
Date: Wed, 6 Dec 2000 15:23:46 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Trashing ext2 with hdparm
In-Reply-To: <90m650$1oe$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012061521210.83-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2000, H. Peter Anvin wrote:

> <HARP>
> Please don't use the path /var/shm... it was a really bad precedent
> set when someone suggested it.  Use /dev/shm.
> </HARP>

And I'll ask again...  If this is now the recommend mount point, can we
have devfs create this directory for us?

-Chris
-- 
Two penguins were walking on an iceburg.  The first one said to the
second, "you look like you are wearing a tuxedo."  The second one said,
"I might be..."
                                              --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
