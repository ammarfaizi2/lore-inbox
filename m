Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbTITIIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 04:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTITIIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 04:08:46 -0400
Received: from mx2.undergrid.net ([64.174.245.170]:27546 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S261652AbTITIIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 04:08:45 -0400
Date: Sat, 20 Sep 2003 01:07:30 -0700
From: "Jeremy T. Bouse" <Jeremy.Bouse@undergrid.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with airo/airo_cs since test4-bk2
Message-ID: <20030920080730.GB10200@UnderGrid.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030919030037.GA5581@UnderGrid.net> <1064077301.14771.1.camel@sven>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <1064077301.14771.1.camel@sven>
X-GPG-Debian: 1024D/29AB4CDD  C745 FA35 27B4 32A6 91B3 3935 D573 D5B1 29AB 4CDD
X-GPG-General: 1024D/62DBDF62  E636 AB22 DC87 CD52 A3A4 D809 544C 4868 62DB DF62
User-Agent: Mutt/1.5.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2003 at 03:01:41AM +1000, Sven Dowideit wrote:
> On Fri, 2003-09-19 at 13:00, Jeremy T. Bouse wrote:
> > 	Since test4-bk2 I've still had increasing problems with the
> > airo/airo_cs driver... test4-bk2 operates but generates an awful lot of
> > frame errors... I've tried test5-bk1 , bk3 and bk5 and they fail to even
> > be able to associate with the AP at all and totally unusable... As soon
> > as the driver and/or card are removed it causes an oops unlike earlier
> > test versions which would just lock the whole machine up...
> i have a cisco 340 in my thinkpad t21 that has been fine so far
> (especially after Rusty fixed the detection problems)

	Hmm... with test4-bk2 I have on the average twice as many frame errors
as I do packets being sent it seems... The test5-bk[135] I've tried
won't even associate with the APs... I would think it was a problem with
the AP but it's two different AP units (brands and models) as well it
worked fine with the older 2.4.20 kernel...

> >=20
> > 	Has anyone else been noticing these problems with a Cisco Aironet 350?
> > I've got it in a Sony Vaio PCG-C1MWP and use it on two networks which
> > use either a LinkSys WAP11 or an Orinoco AP-1000 with the same
> > results...
> >=20
> > 	Regards,
> > 	Jeremy
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bArCzbdYcZyFNB8RAtqCAJ96zezvDa4oGVS5Xew27o1V/jiPSQCgwEbz
XMIlbqnXfdUFssbVUyHc8Gk=
=mREI
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
