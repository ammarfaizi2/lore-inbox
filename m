Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbTGQAJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbTGQAJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:09:52 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:25820 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S271278AbTGQAJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:09:50 -0400
Subject: Re: 2.6 sound drivers?
From: Max Valdez <maxvalde@fis.unam.mx>
To: Jeff Garzik <jgarzik@pobox.com>, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F15E1B5.4020206@pobox.com>
References: <20030716225826.GP2412@rdlg.net>  <3F15E1B5.4020206@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ANEbJke175QZapFQgXPw"
Message-Id: <1058383534.5432.33.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 14:25:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ANEbJke175QZapFQgXPw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have a SBlive too, emu10k1 works pretty well for me, what should I do
for going to ALSA ??=20

I hope the answer is not a, buy a good new supported sound card

:-)
Max
On Wed, 2003-07-16 at 18:37, Jeff Garzik wrote:
> Robert L. Harris wrote:
> >=20
> > I have a soundblaster Live.  I've historically used the OSS drivers as
> > they've worked well for me.  I just tried to load the emu10k1 which
> > loads without error, but mpg123 says it can't open the default sound
> > device.
>=20
>=20
> I am biased, but, it would be nice for people to start testing the=20
> "official" 2.6 sound drivers, ALSA.  The ALSA API has many benefits over=20
> OSS, but needs wide-spread testing and validation.
>=20
> 	Jeff, who is long tired of hacking on OSS drivers :)
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Linux garaged 2.6.0-test1-ac1 #2 SMP Tue Jul 15 06:25:03 CDT 2003 i686 Pent=
ium III (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-ANEbJke175QZapFQgXPw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FaausrSE6THXcZwRAqPlAKD1I5Jcr+99Tivt/Nde4ePJ3NvRFQCguVU4
DaW9+LfYnRwYq/MGPSjiOtQ=
=iiHo
-----END PGP SIGNATURE-----

--=-ANEbJke175QZapFQgXPw--

