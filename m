Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbTGVEYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 00:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbTGVEYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 00:24:48 -0400
Received: from dsl093-170-248.sfo2.dsl.speakeasy.net ([66.93.170.248]:25317
	"HELO parts-unknown.org") by vger.kernel.org with SMTP
	id S269358AbTGVEYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 00:24:47 -0400
Date: Mon, 21 Jul 2003 21:39:17 -0700
From: David Benfell <benfell@greybeard95a.com>
To: linux-kernel@vger.kernel.org
Subject: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030722043917.GA29802@parts-unknown.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-stardate: [-29]0625.91
X-moon: The Moon is Waning Crescent (42% of Full)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

Finally decided to give a development kernel a try on an HP zt1180
laptop.  The kernel build went smoothly and I thought all was well
(well except I guess I've gotta figure out frame buffer support again)
until I started X and discovered that the mouse wasn't working.

I'm guessing this list doesn't allow attachments, and I don't really
want to splat all over everybody with the output I thought relevant,
so I've posted it on my website:

	http://www.parts-unknown.org/hp-zt1180-dmesg.gz
	http://www.parts-unknown.org/hp-zt1180-lspci.gz
	http://www.parts-unknown.org/hp-zt1180.config.gz

wget should work.

Did I miss a configuration option or do some other stupid thing?

--=20
David Benfell
benfell@parts-unknown.org

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (Darwin)

iQEXAwUBPxy/83w5zqzgtjVOFALNqwP/V79uiXHPpz31H++Wg1h7AI+MKs8G/0mO
hAfb8KAgt9YsFPTIe5xHvQT2ieCxEGtSJGkE0pUpNo07Iv3lG7ww9kaRGqzghhZ/
y3Ru8gGB1r6HRGYQtKO2MeHHsJM31fDdLnQbgJIXLvKbluKNNzC3QoAsja+0pEWh
0cX0lDqjXw8D/2MkiIsGh/uBpPYdWsrWmPuqeUQg5bMsi82S08PhXldB/uzGstVo
oorDWyi/+OMwL9Tacwvnds5nSAHIkP96HIOZjDPHExixmKlf0ycYt16NaMbdntN6
Pq4xLIKY+hJPCoXsLa3Mksxdv/yd9Ocdpk6Zu4UNhv5NqpxOkBSN/ahP
=7ij0
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
