Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131569AbQLLTNB>; Tue, 12 Dec 2000 14:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131711AbQLLTMv>; Tue, 12 Dec 2000 14:12:51 -0500
Received: from fe050.worldonline.dk ([212.54.64.206]:19209 "HELO
	fe050.worldonline.dk") by vger.kernel.org with SMTP
	id <S131569AbQLLTMt>; Tue, 12 Dec 2000 14:12:49 -0500
Date: Tue, 12 Dec 2000 19:37:08 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12 not liking high disk i/o
In-Reply-To: <Pine.LNX.4.30.0012121253470.9083-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.30.0012121935100.677-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Mohammad A. Haque wrote:

> i440BX is consistent with mine as is running the drive at UDMA33.
>
> > It happened when I decided to copy old 18GB IDE disk to new 40GB IDE one
> > (both UDMA33, one (18GB src) as primary master, one (40GB dst) as
> > secondary master; i440BX).
>
My system is an old 486DX4-100MHz (AMD processor), SiS 85C496 chipset,
and no UDMA33.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
