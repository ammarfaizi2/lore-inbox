Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTDIFtc (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTDIFtc (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:49:32 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:37016 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262844AbTDIFta (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 01:49:30 -0400
Date: Wed, 9 Apr 2003 08:01:00 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges (was: [MAILER-DAEMON@rumms.uni-mannheim.de: Returned mail: see transcript for details])
Message-ID: <20030409060100.GA28105@schiele.local>
References: <20030408071845.GA10002@schiele.local> <3566580000.1049834178@aslan.btc.adaptec.com> <20030408205136.GA8144@schiele.local> <1049833118.8939.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <1049833118.8939.0.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Robert Schiele <rschiele@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2003 at 09:18:39PM +0100, Alan Cox wrote:
> On Maw, 2003-04-08 at 21:51, Robert Schiele wrote:
> > Thanks for your note.  Hope you didn't feel offended.  At least this wa=
s not
> > my intention.  I just wanted to notify all people related to the affect=
ed
> > driver.
> >=20
> > So it's up to the kernel tree maintainers to bring this fix into their =
trees.
>=20
> Maintainers submit changes to the Linux kernel tree, not vice versa. Its
> push not pull

Well, the reason why I sent the patch to both, the maintainer of the driver
and the maintainers of the trees, is that the maintainers of the trees have
the opportunity to fix one of the more important drivers before they releas=
e a
new "official" version that is broken here, and I think that the change is
quite obvious.

To clarify this: I don't care whether and when the fix goes to the official
trees, because I have the fix for my personal kernel builds and Hubert Mant=
el
has it for the SuSE builds, so it Works-For-Me(TM).

Robert

--=20
Robert Schiele			Tel.: +49-621-181-2517
Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQE+k7ccxcDFxyGNGNcRArsaAJ9ebs/6v1yfIrthqwWF/ARnYx8RVwCg07w1
ZE89ldPcgCHYD8Aivf1GEPw=
=O6kw
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

