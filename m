Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263625AbUECKLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUECKLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 06:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUECKLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 06:11:13 -0400
Received: from mx1.actcom.co.il ([192.114.47.13]:59373 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263625AbUECKLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 06:11:11 -0400
Date: Mon, 3 May 2004 13:09:48 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, intermezzo-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 9/10 intermezzos prefer eating memory
Message-ID: <20040503100947.GE740@mulix.org>
References: <20040502080029.GT20714@krispykreme> <1083486146.3842.1.camel@laptop.fenrus.com> <20040503093719.GB21411@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20040503093719.GB21411@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2004 at 11:37:19AM +0200, J=F6rn Engel wrote:
> On Sun, 2 May 2004 10:22:26 +0200, Arjan van de Ven wrote:
> > On Sun, 2004-05-02 at 10:00, Anton Blanchard wrote:
> > > Hi,
> > >=20
> > > Im sure the 4kB stack brigade wont be too happy about this:
> >=20
> > I thought intermezzo would have been rm -rf'd by now...
>=20
> Should have.  I've written patches for intermezzo a year ago.
> Maintenance is a little slow these days. :)

Likewise. I have a patch[0] for intermezzo stack lossage from 2.5.73
era that hasn't been applied yet, AFAIK. =20

[0] http://www.mulix.org/patches/intermezzo-stack-lossage-2.5.73.diff

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlhprKRs727/VN8sRAjF2AJ9+FxIJJGkmORIiA9nmglwW6cfTEQCeIsr3
U2Wzi8Jfo11bghLqTicqGh4=
=RfqQ
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
