Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbUKVKlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUKVKlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUKVKlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:41:09 -0500
Received: from panda.sul.com.br ([200.219.150.4]:17424 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262036AbUKVKiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:38:12 -0500
Date: Mon, 22 Nov 2004 08:38:01 -0200
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Micah Dowty <micah@navi.cx>
Cc: aris@cefetpr.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Force feedback support for uinput
Message-ID: <20041122103801.GC24080@cathedrallabs.org>
References: <20041110163751.GA13361@navi.cx> <20041112120852.GA25736@cefetpr.br> <20041121085452.GA26087@navi.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFpMipsYUdYbs4p3"
Content-Disposition: inline
In-Reply-To: <20041121085452.GA26087@navi.cx>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FFpMipsYUdYbs4p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
> Also done. Since uinput.txt didn't have any documentation at all,
> I added a short section on basic usage. It should be expanded, but it's
> better than nothing.
that was the idea :)

> +The uinput driver creates a character device, usually at /dev/uinput, that can
the default is '/dev/input/uinput'

Thanks for your work!

--
Aristeu


--FFpMipsYUdYbs4p3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBocGJRRJOudsVYbMRAk8pAKCK1gKxAoiISqG4Jozrxng1luPToQCgrIZG
V9GJCkRLfEKAtAJj5orxBa0=
=Qk9e
-----END PGP SIGNATURE-----

--FFpMipsYUdYbs4p3--
