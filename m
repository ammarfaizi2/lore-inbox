Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQKPQJX>; Thu, 16 Nov 2000 11:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbQKPQJN>; Thu, 16 Nov 2000 11:09:13 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:50189 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129886AbQKPQJG>; Thu, 16 Nov 2000 11:09:06 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14867.65395.355697.262146@wire.cadcamlab.org>
Date: Thu, 16 Nov 2000 09:38:27 -0600 (CST)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PCI configuration changes
In-Reply-To: <200011151005.LAA20027@green.mif.pg.gda.pl>
	<20001116092539.A2453@wire.cadcamlab.org>
	<3A13FDB1.4B4740E1@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Garzik <jgarzik@mandrakesoft.com>]
> Oh yeah, another MCA cleanup to consider -- like EISA, there exists a
> 'MCA_bus' variable which is 0 or 1, depending on the absence or presence
> of MCA bus on the current system.

OK, workin' on it..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
