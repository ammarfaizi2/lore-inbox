Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270383AbTG1Sgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbTG1Sgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:36:32 -0400
Received: from dsl093-170-248.sfo2.dsl.speakeasy.net ([66.93.170.248]:50142
	"HELO parts-unknown.org") by vger.kernel.org with SMTP
	id S270383AbTG1Sga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:36:30 -0400
Date: Mon, 28 Jul 2003 11:51:45 -0700
From: David Benfell <benfell@greybeard95a.com>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse: synaptics (2.6.0-test1|2)
Message-ID: <20030728185145.GE9208@parts-unknown.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <UTC200307281608.h6SG8oY24499.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <UTC200307281608.h6SG8oY24499.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
X-stardate: [-29]0658.89
X-moon: The Moon is New
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2003 18:08:50 +0200, Andries.Brouwer@cwi.nl wrote:
>=20
> > My touchpad stops working with 2.5.74.
>=20
> You mean it worked in 2.5.73 but not in 2.5.74?
>=20
> > howto get gpm running?
>=20
> Ask the gpm maintainer.
>=20
> > what source of information do you use?
>=20
> Vendor docs. User reports. Yes, reports from you.
>=20
Can't help with GPM, but Peter Osterlund and I have gotten his driver
working under Linux 2.6.  This really is a win because now the vertical
scroll pad works -- it never did under my old configuration.

Event device support is important.  Some other things are really not
helpful.

My updated notes are available at:

	http://www.greybeard95a.com/hp/zt1180/

--=20
David Benfell
benfell@parts-unknown.org

--rQ2U398070+RC21q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (Darwin)

iQEXAwUBPyVwwHw5zqzgtjVOFAKhpgP+NZbI6siW32e+4z41I+oniOfMDlLXx6pA
M3XKqJ4tjMPhfz4rEvHgnPkIefgRPXZ+rKkf8tWxJPRJ3VerY6elx+uY5we5j65R
hWqVH6aSYtqDJq/j6hW+dofiaM9+0ga0DqncxTPdE2BSSRRQDWM4oXOU1Wr1TC/Z
823ojUUZEpgEAJ2iwBOT1ZK4nO6in1bT4wlwirbxmjy1Wt8UGHlbakDFoheB5hO8
iJkfYMIXSdA6wkjCgDDICjeEu5qDEKgfVAyg0MTiH5NGp2R+yOrdwrTma8M+4ZOC
kYzvyI5JJ4+t9M44U9HQ9WQ2ggkPCLlR58QstbTp+/LOqdUdwr3ZTRb5
=HCzN
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
