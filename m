Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUCEUy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUCEUy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:54:56 -0500
Received: from D700a.d.pppool.de ([80.184.112.10]:5595 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262701AbUCEUyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:54:40 -0500
In-Reply-To: <1078487159.3300.23.camel@venus.local.navi.pl>
References: <1078434953.1961.13.camel@venus.local.navi.pl> <20040305082350.GO31750@suse.de> <1078487159.3300.23.camel@venus.local.navi.pl>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7--719041434"
Message-Id: <E0C14E0F-6EE6-11D8-9C10-000A9597297C@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
Date: Fri, 5 Mar 2004 21:51:29 +0100
To: =?UTF-8?Q?Olaf_Fr=C4=85czyk?= <olaf@cbk.poznan.pl>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-7--719041434
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed

On Mar 5, 2004, at 12:45 pm, Olaf Fr=C4=85czyk wrote:

CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:             hdc
drive speed:            63
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         1
Can write CD-RW:        1
Can read DVD:           1
Can write DVD-R:        1
Can write DVD-RAM:      1
Can read MRW:           0
Can write MRW:          0

DVD-RAM mounting works for me.

However shouldn't this table also contain DVD-RW, DVD+R and DVD+RW?

This is a LG 4040B which is capable of this formats also.

Servus,
       Daniel

--Apple-Mail-7--719041434
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQEjoUjBkNMiD99JrAQLjowf+M8NZ5bAbXnivmW8aBFmvazBx7xX/aSxK
ls2ajqQ9JzMMT9X0F5QJ9okUjAFlnHgZfyEmux4weQwJ+ui2fIjGDSE/jXmjKEPb
xO3IZaU18QXJceYo4W1U9By/96L2HKAQwQ/4dCzjglFHi7/lJgG75MrDYeaznvVN
i7bPg/UnoZ45XjO0fWar9ejHi2eR/Ccf3Pog5ecOWPNiXHbGsMzevGqsbJ8iQUix
oH1VGW2nAgNkzEDeiuPqmOHILv4ik3r9oh7mgyZQlcYqB3WGOMaCZYmZrJaIrET8
c85Ey5qN2rFUwgSASt978nJbeT5cHEzIqpSa+K6LeHUJ+xLsAjyZeA==
=D0ag
-----END PGP SIGNATURE-----

--Apple-Mail-7--719041434--

