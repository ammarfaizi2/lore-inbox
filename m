Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129260AbQKWRkR>; Thu, 23 Nov 2000 12:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129248AbQKWRkI>; Thu, 23 Nov 2000 12:40:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40967 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129768AbQKWRj2>; Thu, 23 Nov 2000 12:39:28 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "Hyper-Mount" option possible???
Date: 23 Nov 2000 09:09:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vjivr$gri$1@cesium.transmeta.com>
In-Reply-To: <3A1D3DF9.9199C744@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A1D3DF9.9199C744@earthlink.net>
By author:    Robert L Martin <robertlmarti@earthlink.net>
In newsgroup: linux.dev.kernel
>
> Not on list just throwing an idea out.
> One thing that "bugs" me is if a given drive has more than one partion
> each partion has to be mounted seperatly.
> With CDs this also means you can not mount "split" cds in full if you
> want to. Soo  Given that Super-Mount is already taken, How about (in
> 2.5??)  hashing out a Hypermount option.
> The way it could work is if you mount a full drive say "hdd" and have
> each partion mounted on a tree from the mount point
> of the drive.
> 

This sounds a lot like cdfs.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
