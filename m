Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRDPLaC>; Mon, 16 Apr 2001 07:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDPL3n>; Mon, 16 Apr 2001 07:29:43 -0400
Received: from cdsl18.ptld.uswest.net ([209.180.170.18]:21616 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S130820AbRDPL3e>;
	Mon, 16 Apr 2001 07:29:34 -0400
Date: Mon, 16 Apr 2001 04:29:48 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci.c problems in latest kernels?
Message-ID: <20010416042947.B16720@debian.org>
In-Reply-To: <20010414213546.A1590@devserv.devel.redhat.com> <20010415043836.C15118@debian.org> <20010415232909.A28478@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010415232909.A28478@devserv.devel.redhat.com>; from zaitcev@redhat.com on Sun, Apr 15, 2001 at 11:29:09PM -0400
X-Operating-System: Linux galen 2.4.3-ac4+lm+bttv
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 15, 2001 at 11:29:09PM -0400, Pete Zaitcev wrote:
> > I'm not sure of that.  Sometimes keys get "stuck" in the down position
> > with my USB keyboard (mechanical switches, so the keys themselves are n=
ot
> > sticking) and usually when that happens I can find a line like the one
> > quoted above in the logs. [...]
>=20
> The printout is a valuable diagnostic tool for hacking but
> is useless for a user (actually dangerous, as it brings computers
> down with /var overflow). The best option would be to have
> it configurable with a module parameter.

That sounds like a good idea actually, under kernel hacking perhaps?  It
seems to me that the messages do indicate some kind of non-fatal problem
(that may not be true?) but I agree it is murderous to /var on a small
system.  Given that I now consider a small system one with a /var of under
300 megs, well..  =3D)

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

Techical solutions are not a matter of voting. Two legislations in the US
states almost decided that the value of Pi be 3.14, exactly. Popular vote
does not make for a correct solution.
        -- Manoj Srivastava


--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjra16sACgkQj/fXo9z52rNOpQCfXJ8jPYX9s8csZUmJZsWYO6pr
xhEAn3O1f649iQ556IFr3CVlGksyqDWx
=IqAy
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
