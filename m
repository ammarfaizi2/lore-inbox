Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUCGHBx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 02:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUCGHBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 02:01:46 -0500
Received: from mx1.actcom.net.il ([192.114.47.13]:26041 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S261772AbUCGHBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 02:01:44 -0500
Date: Sun, 7 Mar 2004 09:00:07 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 unresolved symbols
Message-ID: <20040307070007.GA24583@mulix.org>
References: <404AAB55.E47F2E7A@isn.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <404AAB55.E47F2E7A@isn.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 07, 2004 at 12:55:49AM -0400, Garst R. Reese wrote:

> Unresolved symbols from insmod eepro100 are:
> mii_ethtool_sset
> mii_link_ok
> mii_ethtool_gset
> mii_nway_restart
> mii_check_link

Load the mii module (or use modprobe rather than insmod, which should
do this automatically).

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFASsh3KRs727/VN8sRAuGgAJ497GOLc0LL1Ezu0suU+ZxGGsAy6gCcCdjO
IPQwR5cwKS0G69EI/C6VW6o=
=m6dC
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
