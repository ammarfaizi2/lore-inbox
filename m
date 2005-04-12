Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVDLQ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVDLQ0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVDLQ0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:26:21 -0400
Received: from lug-owl.de ([195.71.106.12]:49841 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262434AbVDLQXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:23:33 -0400
Date: Tue, 12 Apr 2005 18:23:32 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412162332.GL4965@lug-owl.de>
Mail-Followup-To: "Kilau, Scott" <Scott_Kilau@digi.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
	linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
References: <335DD0B75189FB428E5C32680089FB9F122152@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F122152@mtk-sms-mail01.digi.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2feizKym29CxAecD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-12 10:30:19 -0500, Kilau, Scott <Scott_Kilau@digi.com>
wrote in message <335DD0B75189FB428E5C32680089FB9F122152@mtk-sms-mail01.dig=
i.com>:
> > There are people who just want the card supported.  There's no reason
> > to deny the driver to them.
>=20
> Oh, it *is* supported, using our GPL'ed DGNC driver available on our
> ftp/web site.
>=20
> This is not some argument of closed binaries versus open source
> binaries,
> As both the JSM and DGNC drivers are completely open source and GPL'ed.

So then please do *all* the work, not only the first half. Writing a
driver is a nice thing, but doesn't actually help anybody. Doing a
driver for eg. Linux means to *care* for it. That is, writing it is only
the very first step of a longer way. The next step is to supply patches
for review. Then you'll get some feedback and you're expected to work
the issues out. Then you can again submit patches -- and repeat this
until it's merged.

> This is about having the users of this card end up=20
> getting a worse experience by using the JSM driver.

Then please work on getting your driver included into Linus' and Andrews
kernel sources. For some time, both drivers may co-exist, but once one
driver is *really* superior over the other one and there are *no* issues
left that force people to use the worse driver, that one will die out at
some time.

But please be prepared to be in a competitive position. You've won't get
your driver included by just telling once about it; you'll need to work
towards that goal, and probably monitor the driver to be useable in the
future.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCW/YEHb1edYOZ4bsRAvNfAJ9pfE9jCurz2FD1HFU1NUGxrzlaMwCeO697
jjYdCRfkstMQNFoPqUXBWp4=
=qBk+
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
