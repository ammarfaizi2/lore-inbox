Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTIZPVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTIZPVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:21:35 -0400
Received: from smtp5.clb.oleane.net ([213.56.31.25]:8378 "EHLO
	smtp5.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262352AbTIZPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:21:32 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030926150628.GA10521@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
	 <20030926102403.GA8864@ucw.cz>
	 <1064572898.21735.17.camel@ulysse.olympe.o2t>
	 <1064581715.23200.9.camel@ulysse.olympe.o2t> <20030926134116.GA9721@ucw.cz>
	 <1064585567.23200.15.camel@ulysse.olympe.o2t>
	 <20030926141750.GA10183@ucw.cz>
	 <1064586116.23200.17.camel@ulysse.olympe.o2t>
	 <20030926142607.GA10344@ucw.cz>
	 <1064587824.23200.19.camel@ulysse.olympe.o2t>
	 <20030926150628.GA10521@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9o8Nqp4EZD+lyramNQ+X"
Organization: Adresse personelle
Message-Id: <1064589686.23200.24.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Fri, 26 Sep 2003 17:21:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9o8Nqp4EZD+lyramNQ+X
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 26/09/2003 =E0 17:06, Vojtech Pavlik a =E9crit :
> On Fri, Sep 26, 2003 at 04:50:25PM +0200, Nicolas Mailhot wrote:
> > Le ven 26/09/2003 ? 16:26, Vojtech Pavlik a =E9crit :
> > > On Fri, Sep 26, 2003 at 04:21:57PM +0200, Nicolas Mailhot wrote:
> > > > Le ven 26/09/2003 ? 16:17, Vojtech Pavlik a =E9crit :

> > > > > If that doesn't work, you have a more severe problem than a stuck=
 key,
> > > > > that wouldn't be solved by stopping the repeat.
> > > >=20
> > > > It stops the repeat all right.
> > > > The problem is the keyboard is dead afterwards:(
> > >=20
> > > That's very interesting. Can you enable DEBUG in i8042.c and post a l=
og?
> >=20
> > Will it be of any use for an USB keyboard ? (just asking)
>=20
> No. For an USB keyboard I'd suggest unplugging it, then re-plugging and
> then it should work. Then look at what 'dmesg' says.

Ok. I think I've already tried this and the outcome was not satisfying,
and I sort of remember dmesg was empty. I'll try this with usb debug
enabled this evening or next monday. (I just hope something comes out of
this - 2.6 is great till the keyboard goes mad).

--=20
Nicolas Mailhot

--=-9o8Nqp4EZD+lyramNQ+X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dFlyI2bVKDsp8g0RAhldAJ9LAKo71b+VkdjxIAmNV9fk2Usk+gCfUObG
yd+xkO/2qGO4w+nr6kkGJeY=
=FpL/
-----END PGP SIGNATURE-----

--=-9o8Nqp4EZD+lyramNQ+X--

