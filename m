Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRJYQIu>; Thu, 25 Oct 2001 12:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRJYQIk>; Thu, 25 Oct 2001 12:08:40 -0400
Received: from rosebud.imaginos.net ([64.173.180.66]:2432 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S273881AbRJYQIY>; Thu, 25 Oct 2001 12:08:24 -0400
Date: Thu, 25 Oct 2001 09:08:32 -0700 (PDT)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dvd and filesystem errors under 2.4.13
In-Reply-To: <E15wjKP-0004fk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110250907210.425-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rev 6.2.1

Are you saying this is possibly a hardware issue ?

============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759



On Thu, 25 Oct 2001, Alan Cox wrote:

> Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
> ext2_free_blocks: bit already cleared for block 133384
> Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
> ext2_free_blocks: bit already cleared for block 133385

Thats indicating memory on on disk corruption. It is something you should
be concerned about.  What version of aic7xxx is on the kernel that is
stable ?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72DkIdygyS8O4zQ0RAiMCAKC+JgKJaT48o4sErJmeDO+vykxmeQCghm9l
8sGl2cJFTcCYchJD5z3+l54=
=Khu2
-----END PGP SIGNATURE-----


