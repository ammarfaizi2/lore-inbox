Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129516AbQKUEvc>; Mon, 20 Nov 2000 23:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129683AbQKUEvW>; Mon, 20 Nov 2000 23:51:22 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6664 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129516AbQKUEvK>; Mon, 20 Nov 2000 23:51:10 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14873.63469.47294.42852@wire.cadcamlab.org>
Date: Mon, 20 Nov 2000 22:19:57 -0600 (CST)
To: Nix <nix@esperi.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu>
	<20001116150704.A883@emma1.emma.line.org>
	<20001116171618.A25545@athlon.random>
	<20001116115249.A8115@wirex.com>
	<20001117003000.B2918@wire.cadcamlab.org>
	<87g0kq3vpp.fsf@loki.wkstn.nix>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Nix <nix@esperi.demon.co.uk>]
> I haven't checked this or anything, but it seems to me that all you
> need is a cooperating process outside the jail, that opens some
> world-readable directory

In that case, you are already outside. (:  Why bother with the chroot
process at all?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
