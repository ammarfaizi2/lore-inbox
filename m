Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbUKLTSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUKLTSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKLTRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:17:04 -0500
Received: from mail.il.fontys.nl ([145.85.127.32]:42948 "EHLO
	mordor.il.fontys.nl") by vger.kernel.org with ESMTP id S261903AbUKLTQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:16:34 -0500
From: "Ed Schouten" <ed@il.fontys.nl>
Date: Fri, 12 Nov 2004 20:16:24 +0100
To: "M. A. Imam" <maimam@wichita.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: howt o remake the kernel
Message-ID: <20041112191624.GB16907@il.fontys.nl>
References: <41944C86@webmail.wichita.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <41944C86@webmail.wichita.edu>
X-Message-Flag: Please upgrade your mailreader to Mozilla Thunderbird at http://www.mozilla.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Imam,

On Fri 12 Nov 2004 12:17 PM, M. A. Imam wrote:
> I am new to linux. i am working on my thesis... i have made some changes =
to=20
> net/ipv4/tcp.c now i need to remake my kernel. right?

If you are running Linux 2.6, you only need to run `make` again. The Linux
build-script will detect the changes, because of a changed timestamp.

Yours,
--=20
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
 GPG key: finger ed@il.fontys.nl

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBlQwIyx16ydahrz4RAhEFAKDKXO8m8Aprh+Oqv9h0yOSpN2GfKQCgi5oV
Hk1NKIBo1auckHICXe687iQ=
=37nT
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
