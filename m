Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbQKKHb2>; Sat, 11 Nov 2000 02:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129948AbQKKHbS>; Sat, 11 Nov 2000 02:31:18 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:55565 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129916AbQKKHbC>; Sat, 11 Nov 2000 02:31:02 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14860.62888.81093.51268@wire.cadcamlab.org>
Date: Sat, 11 Nov 2000 01:30:48 -0600 (CST)
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: George Anzinger <george@mvista.com>, Dan Aloni <karrde@callisto.yi.org>,
        Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <Pine.LNX.4.21.0011100051190.31850-100000@callisto.yi.org>
	<3A0C2813.E7CB42D2@mvista.com>
	<20001110215628.A28057@wire.cadcamlab.org>
	<m3u29ff51b.fsf@matrix.mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Chmouel Boudjnah <chmouel@mandrakesoft.com>]
> i would recommend to use the orig.el[1] from frederic.lepied with
> Emacs, it save any files before editing with a particuliar prefix

I'll take a look, thanks.

> and you can generate the patch with the gendiff script (included with
> rpm).

I did not know about gendiff (as a Debian user I rarely use RPM).
Anyway I prefer my patch[2] as it's more flexible.  gendiff doesn't let
you pass in other diff options (true, many are not useful in this
context but think about -d, -p, -b and -U).

Peter

[2] again, http://bugs.debian.org/64958
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
