Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130255AbQLPE4G>; Fri, 15 Dec 2000 23:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQLPEz4>; Fri, 15 Dec 2000 23:55:56 -0500
Received: from zeus.kernel.org ([209.10.41.242]:26117 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130026AbQLPEzm>;
	Fri, 15 Dec 2000 23:55:42 -0500
Date: Sat, 16 Dec 2000 05:22:55 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
To: infernix <infernix@infernix.nl>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot 2.4.0-test12 (0224 AX:0212 BX:BC00 CX:5101 DX:000.)
In-Reply-To: <000701c066fb$aab18900$1500a8c0@infernix>
Message-ID: <Pine.LNX.4.30.0012160521580.2805-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, infernix wrote:

> Hi,
>
> After compiling 2.4.0-test12 on my (P2-266, 440LX) Debian 2.2 system (make
> bzdisk), i am unable to boot the kernel. When I boot up with the floppy
> disk, I do get the Loading...... screen (I think it does load completely),
> but afterwards I get this error:
>
> 0224
> AX:0212
> BX:BC00
> CX:5101
> DX:000.
>
I've seen this a few times too. It's normally caused by a bad floppy.
Try another floppy.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
