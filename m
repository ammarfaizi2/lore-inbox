Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752646AbWKRUk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWKRUk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 15:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbWKRUk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 15:40:29 -0500
Received: from nsm.pl ([195.34.211.229]:35794 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1752646AbWKRUk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 15:40:28 -0500
Date: Sat, 18 Nov 2006 21:40:13 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: boot from efi on x86_64
Message-ID: <20061118204013.GA13645@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200611182107.03667.spatz@psybear.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <200611182107.03667.spatz@psybear.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2006 at 09:07:03PM +0200, Dror Levin wrote:
> looking at the kernel source, after constant failures to boot linux on a =
core=20
> 2 imac, has made me understand that only i386 and ia64 support efi bootin=
g,=20
> but x86_64 does not.
> it makes sense, if you think about it... AFAIK, until the new core 2 imac=
s=20
> were out there was no x86_64 efi pc, so why should the kernel support it?

  Few days ago I played with Intel servers with EM64T Xeons (NetBurst
based). They are x86_64, and motherboard (Intel chipset) utilised EFI.

--=20
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFX2+t10UJr+75NrkRAksTAJ49IUE0/mB+vbDII531xRnhJTl/8ACfW80B
5AphRmB9g58kzWzLa/zfoI4=
=fMW5
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
