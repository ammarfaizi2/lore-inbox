Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbTCTJxA>; Thu, 20 Mar 2003 04:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCTJxA>; Thu, 20 Mar 2003 04:53:00 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:2518 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261334AbTCTJw7>; Thu, 20 Mar 2003 04:52:59 -0500
From: Erik Hensema <usenet@hensema.net>
Subject: Re: Deprecating .gz format on kernel.org
Date: Thu, 20 Mar 2003 10:03:57 +0000 (UTC)
Message-ID: <slrnb7j4ga.1cf.usenet@bender.home.hensema.net>
References: <3E78D0DE.307@zytor.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

H. Peter Anvin (hpa@zytor.com) wrote:
> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.

[...]

I think it may be better to dump the .gz format for 2.5 and the forthcoming
2.6 series in favour of .bz2. Keep .gz for 2.[0-4] for those who need it (I
certainly don't).

- -- 
Erik Hensema <erik@hensema.net>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+eZINuNWfqpFSu/cRAkJfAJ9LNq+2krlpaU9PTNE0m0pVgMtgngCg+L8G
FT6d5flYtelPMNCoEvoZQTY=
=MUhg
-----END PGP SIGNATURE-----
