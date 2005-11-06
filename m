Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVKFRVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVKFRVh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVKFRVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:21:37 -0500
Received: from attila.bofh.it ([213.92.8.2]:21202 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1751065AbVKFRVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:21:37 -0500
Date: Sun, 6 Nov 2005 18:21:28 +0100
To: Harald Dunkel <harald.dunkel@t-online.de>, 333052@bugs.debian.org
Cc: Pozsar Balazs <pozsy@uhulinux.hu>, Kay Sievers <kay.sievers@vrfy.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug#333052: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051106172128.GA8721@wonderland.linux.it>
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org> <20051105184802.GB25468@ojjektum.uhulinux.hu> <436DA120.9040004@t-online.de> <436E181D.6010507@t-online.de> <20051106152924.GB16987@ojjektum.uhulinux.hu> <436E37E8.3070807@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <436E37E8.3070807@t-online.de>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 06, Harald Dunkel <harald.dunkel@t-online.de> wrote:

> I hadn't seen Rusty's patch on Debian's bts, until you mentioned
> it. I have applied both patches now, and rebooted twice: By now
> it worked. But that's what I thought before.
It cannot be relevant, because when the bug is triggered / is still
read-only.

> Are there several modprobe's running in parallel? Or does modprobe
Yes.

--=20
ciao,
Marco

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDbjuYFGfw2OHuP7ERAiEcAJ9GpF9Fr3ylZvPzkZXgt695dDoqYQCfa8ix
CqGrKFXmRSQ33LiVcQ+QIhA=
=+Noo
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
