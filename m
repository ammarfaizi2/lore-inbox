Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130917AbQKLTwI>; Sun, 12 Nov 2000 14:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130841AbQKLTv5>; Sun, 12 Nov 2000 14:51:57 -0500
Received: from getafix.lostland.net ([216.29.29.27]:15139 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S130658AbQKLTvw>; Sun, 12 Nov 2000 14:51:52 -0500
Date: Sun, 12 Nov 2000 14:51:50 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>
Message-ID: <Pine.BSO.4.21.0011121446410.10992-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Nov 2000 tytso@mit.edu wrote:

[snip]
> 2. Capable Of Corrupting Your FS/data
> 
>      * Use PCI DMA by default in IDE is unsafe (must not do so on via
>        VPx, x < 3) (Vojtech Pavlik --- requires chipset tuning to be
>        enabled according to Andre Hedrick --- we need to turn this on by
>        default, if it is safe -- TYT)
[snip]

Does this include VPx were x does not exist?

(vt82c686a VIA Apollo VP, specifically Asus K7M)

Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
