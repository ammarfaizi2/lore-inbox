Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269179AbTCBKdj>; Sun, 2 Mar 2003 05:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269181AbTCBKdi>; Sun, 2 Mar 2003 05:33:38 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:34998 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S269179AbTCBKdh>; Sun, 2 Mar 2003 05:33:37 -0500
Date: Sun, 2 Mar 2003 12:43:09 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple & vs. && and | vs. || bugs in 2.4 and 2.5
Message-ID: <20030302104308.GK4047@actcom.co.il>
References: <20030302102751.GA26028@defiant>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Content-Disposition: inline
In-Reply-To: <20030302102751.GA26028@defiant>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2003 at 02:27:51AM -0800, Norbert Kiesel wrote:
> Hi,
> inspired by the recent bug report from Muli Ben-Yehuda (see
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D104647477025930), I
> hunted for similar bugs in 2.4 and 2.5 using a simple grep:

In the interest of giving credit where credit is due, John Levon found
the bug and sent me the patch. He did this for several other drivers
as well.=20

> Should I create patches for these and send them to the maintainers?

Definitely. You can ignore the 2.4.20 trident one, I'll fix it and
push it to Marcelo.=20

Thanks,=20
Muli.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--enGqbSaueFq5omEL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+YeA8KRs727/VN8sRAhtrAKCxpdhs6U4uqZFbPmRWrWmiQD4AKwCbBX5L
CQRMVhSF1zj7yhksiX+XBAM=
=Qbuu
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
