Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTGHPI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTGHPI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:08:28 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38148 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263722AbTGHPIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:08:20 -0400
Date: Tue, 8 Jul 2003 17:22:56 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Subject: Re: Linksys gpl code [OT]
Message-ID: <20030708152255.GJ20605@lug-owl.de>
Mail-Followup-To: Kernel <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <1057663858.3959.41.camel@miyazaki> <20030708144509.GE20605@lug-owl.de> <20030708160519.A11679@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <20030708160519.A11679@infradead.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-08 16:05:19 +0100, Christoph Hellwig <hch@infradead.org>
wrote in message <20030708160519.A11679@infradead.org>:
> On Tue, Jul 08, 2003 at 04:45:10PM +0200, Jan-Benedict Glaw wrote:
> > On Tue, 2003-07-08 12:30:58 +0100, Matthew Hall <matt@ecsc.co.uk>
> > wrote in message <1057663858.3959.41.camel@miyazaki>:
> > >=20
> > > http://www.linksys.com/support/gpl.asp
> >=20
> > I downloaded that kernel.tgz and diff'ed it out - it's a *hugh* patch
> > removing tons of comments and #if 0 ... #endif parts. That makes it
> > more complicated to find the "interesting" parts for us, but also it
> > will get hard for them to ever port that changes over to 2.4.current...
>=20
> Can you upload it somewhere or is it too big for that?

http://lug-owl.de/~jbglaw/linksys-kernel-2.4.5.patch.gz

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CuHPHb1edYOZ4bsRArtPAJ4kJQNaL0fIej91pH6rRvtDkG5vkQCeMpmn
+a/J1CJXNs8/PO+U+wDYCwQ=
=2YYD
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
