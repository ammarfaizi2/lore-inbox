Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275527AbRJYQuy>; Thu, 25 Oct 2001 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJYQuo>; Thu, 25 Oct 2001 12:50:44 -0400
Received: from rosebud.imaginos.net ([64.173.180.66]:20864 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S275552AbRJYQue>; Thu, 25 Oct 2001 12:50:34 -0400
Date: Thu, 25 Oct 2001 09:50:53 -0700 (PDT)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dvd and filesystem errors under 2.4.13
In-Reply-To: <E15wnTN-0005MC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110250947200.530-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ok, well I just noticed I have been recieving "hdc: lost interupt" in
dmesg when trying to read from the dvd (in both kernel versions). Although
play is smoother in 2.4.9, its still hosing. Maybe the scsi issue and the
dvd issue relate to a crappy or soon to be crappy pci bus ?




			Jim


============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759



On Thu, 25 Oct 2001, Alan Cox wrote:

> Are you saying this is possibly a hardware issue ?

Could be a cabling or RAM issue,could also be a driver bug of some
kind
- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72ELydygyS8O4zQ0RAsMIAJ9CsEhn2NwHj37Gc3nl6uiHYhhg1ACeLLiF
GLqVNXf2kPb5KsUAm46VXe8=
=eeIa
-----END PGP SIGNATURE-----


