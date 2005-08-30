Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVH3Qtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVH3Qtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVH3Qtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:49:53 -0400
Received: from www.nuit.ca ([66.11.160.83]:8339 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S932222AbVH3Qtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:49:52 -0400
Date: Tue, 30 Aug 2005 12:49:40 -0400
From: "SR, ESC" <simon@nuit.ca>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.6.13: jfsCommit
Message-ID: <20050830164939.GA11199@pylon>
References: <20050830115950.GA8764@pylon> <1125420432.9223.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1125420432.9223.3.camel@kleikamp.austin.ibm.com>
X-GPG-KeyServer: hkp://subkeys.pgp.net
X-Operating-System: Debian GNU/Linux
User-Agent: mutt-ng devel-r316 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le mar 2005-08-30 a 12:48:17 -0400, Dave Kleikamp <shaggy@austin.ibm.com> a=
 dit:
> On Tue, 2005-08-30 at 07:59 -0400, SR, ESC wrote:
>=20
> I think the problem may be a recent change to jfs_delete_inode.  Does
> this patch fix the problem?

thanks, i'll give a try.=20

simon

> --=20
> David Kleikamp
> IBM Linux Technology Center
>=20

--=20
Microsoft is to operating systems & security ....
                                 .... what McDonalds is to gourmet cooking.
                -- unknown; seen in Marc Merlin's .sig

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQGVAwUBQxSOImqIeuJxHfCXAQI5NAv+LD3/rB2av/afLXO0A26e0VM/vsveJM3a
c8DRsU1NJepK/t6wwPRYQ1M3eGdvA9g9El9SvHi6glh0c5vPXOzKhKmk02zof1vn
QgmQ21VJkCrmQYBsfINW9nwkhVWGSgM2akpnhbOe5XU0srOxKTaie2W/+Xk7B4L4
vWqEKv1EjIANOmiItdi4+saH+Ymj9s/kNlNCpUYudI2Ese8ben/KLwD9zoJJQJVy
JnS4RnCKvGT7DrLE1aTlj1iwSQh78h2YiVa5U8XJvKc0kSAXMxROloaaMDDdyGHu
GkJ9iLc606xnWECH2fN73oYgdO0adNy+Tf0oSsJQ/tQXp7GO3xdfOy5Lfp7HXs3V
be50UO/z+5c5ZQEx5eNyzfw0AULD5IM3qTXuxLdQc3Xo/RoPjLftJHXnWsIOUvVi
wMSTwVMnutroGcbraU4WH0riIRHASNGNl2ajmTPGAjIU572l2xKwaW0tOqp8p9CV
mMoM8qCYdU6+K0I9hadeQjLkaeSlzG9z
=DJmk
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
