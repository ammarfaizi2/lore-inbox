Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUAKNJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUAKNJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:09:21 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:57046 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265877AbUAKNJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:09:13 -0500
Date: Sun, 11 Jan 2004 14:09:10 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111130910.GA5916@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net> <20040111120053.C1931@flint.arm.linux.org.uk> <20040111123208.GA4766@piper.madduck.net> <20040111125404.E1931@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20040111125404.E1931@flint.arm.linux.org.uk>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Russell King <rmk+lkml@arm.linux.org.uk> [2004.01.11.1354 +0100=
]:
> Hope this helps to make things a little clearer.

It does. Thanks. (It's very cool!)

> ... which seems to be exactly the same as my 3ccfe575bt card I have here.
> I note though that the product description seems to be wrong (the PCI IDs
> are identical.)  The card is most definitely "3CCFE575BT" and not "3c575".

Well, it does have a -D after the 3CCFE575BT (as read on the card
itself)

Anyhow, I will recompile 2.6.1 with 3c59x and then report.

Thanks for your time!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"every day is long. 86400 doesn't fit in a short."

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAUr2IgvIgzMMSnURAp8sAKCFDb2/xoBg5hTHEoL+uceg5egn0wCfXBwo
KC2B/uapKfEFcnegMqotGcY=
=gs/E
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
