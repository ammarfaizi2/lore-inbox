Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUAMWjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUAMWih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:38:37 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:59353 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265663AbUAMWhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:37:43 -0500
Date: Tue, 13 Jan 2004 23:37:39 +0100
From: martin f krafft <madduck@madduck.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-ID: <20040113223739.GA6268@piper.madduck.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040113215355.GA3882@piper.madduck.net> <20040113143053.1c44b97d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20040113143053.1c44b97d.rddunlap@osdl.org>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Randy.Dunlap <rddunlap@osdl.org> [2004.01.13.2330 +0100]:
> Any other possibly related messages in the logs?

it's IPsec related since it always appears together with racoon
entries

> What kernel version?  like 2.4.2x ??  other patches applied?
> [not 2.6.x since modprobe is being used]

2.6.1 in fact.

why is modprobe not being using in 2.6.x anymore?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"if you can dream it, you can do it"
                                                        -- walt disney

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABHMzIgvIgzMMSnURAp4wAJ9XRWF+cb0NgdjQrAxF0BVhipyYbgCgy+Lg
89oaKGWGkhLQG4jhy3Q8miw=
=vezy
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
