Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265113AbUE0Tpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUE0Tpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUE0Tpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:45:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51404 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265113AbUE0Tp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:45:27 -0400
Date: Thu, 27 May 2004 15:45:13 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [Prism54-devel] Re: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
Message-ID: <20040527194513.GV3330@ruslug.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
References: <20040524083003.GA3330@ruslug.rutgers.edu> <20040524085727.GR3330@ruslug.rutgers.edu> <40B62F29.6090101@pobox.com> <20040527192733.GB14186@logos.cnet> <40B6424D.7030203@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NJPV7Gg6aA3gXYsj"
Content-Disposition: inline
In-Reply-To: <40B6424D.7030203@pobox.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NJPV7Gg6aA3gXYsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2004 at 03:32:29PM -0400, Jeff Garzik wrote:
> Marcelo Tosatti wrote:
> >IMO support for new hardware (new drivers) which dont break existing=20
> >setups are fine.
> >
> >Jeff, you are actively maintaining most of the network drivers in v2.4, =
if=20
> >you are OK with the inclusion of this, I'm OK.
> >
> >Does this make sense?
>=20
>=20
> Yup, makes sense and sounds good to me.
>=20
> Luis, feel free to send me the 2.4.x version of the prism54 driver --=20
> after addressing my comments, of course ;-)

Great. I'll fix all those patches up again for you and Marcelo. For future
development I've asked other prism54 developers to first send patches to
netdev for review/approval. Maybe we *should* do away with prism54-devel=20
mailing list and just use netdev as was once suggested by someone...

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--NJPV7Gg6aA3gXYsj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtkVJat1JN+IKUl4RAhK5AKCMLsSOj/ljPh3ka+HrobMB7YMz6QCeJu1w
VI+K4jJGD+DN/exAHFQyotw=
=PWZW
-----END PGP SIGNATURE-----

--NJPV7Gg6aA3gXYsj--
