Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRBGHsB>; Wed, 7 Feb 2001 02:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129885AbRBGHrv>; Wed, 7 Feb 2001 02:47:51 -0500
Received: from blackhole.adamant.net ([212.26.128.69]:16921 "EHLO
	blackhole.adamant.net") by vger.kernel.org with ESMTP
	id <S129834AbRBGHre>; Wed, 7 Feb 2001 02:47:34 -0500
Date: Wed, 7 Feb 2001 09:47:25 +0200
From: Alexander Trotsai <mage@adamant.net>
To: linux-kernel@vger.kernel.org
Subject: Massive speed slowdown with any kernel after 2.4.1
Message-ID: <20010207094725.D12250@blackhole.adamant.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
Organization: Adamant ISP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I have PIII/128Mb/IDE uDMA 66 PC
I try 2.4.1ac1, ac2 and 2.4.2pre1
And all this kernel after message "Freeing unused kernel memmory" highly slowing
Even cursor (I have framebuffer) blink slowly
But (via vmstat) no processor used, no disk operation.
I try to compile both gcc from redhat and kgcc and have no difference
But with the same config 2.4.0ac10 work Ok.

____________________________________________________________________
Info&Contacts -- RIPE: MAGE-RIPE, InterNic: AT2963, ICQ: 18035130
PGP: ftp://blackhole.adamant.net/pgp/mykey.pgp.asc
Trouble of the day: excessive collisions & not enough packet ambulances
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
