Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKINb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKINb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKINb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:31:27 -0500
Received: from admingilde.org ([213.95.32.146]:12979 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750746AbVKINb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:31:26 -0500
Date: Wed, 9 Nov 2005 14:31:25 +0100
From: Martin Waitz <tali@admingilde.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
Message-ID: <20051109133124.GP9633@admingilde.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20051108183511.GA12043@mipter.zuzino.mipt.ru> <Pine.LNX.4.58.0511081025420.15288@shark.he.net> <20051108190048.GA12240@mipter.zuzino.mipt.ru> <Pine.LNX.4.58.0511081048000.15288@shark.he.net> <20051108192642.GA14202@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NT59pYSnj1ZLVgEN"
Content-Disposition: inline
In-Reply-To: <20051108192642.GA14202@mipter.zuzino.mipt.ru>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NT59pYSnj1ZLVgEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 08, 2005 at 10:26:42PM +0300, Alexey Dobriyan wrote:
> > >   XMLTO  Documentation/DocBook/wanbook.html
> > > XPath error : Undefined variable
> > > compilation error: file file:///usr/share/sgml/docbook/xsl-stylesheet=
s-1.66.1/xhtml/docbook.xsl
> > > line 114 element copy-of
> > > xsl:copy-of : could not compile select expression '$title'
> > > XPath error : Undefined variable
> > > $html.stylesheet !=3D ''
> >=20
> > Is that after applying Martin's docbook patches yesterday?
> > (I haven't tested that yet.)
>=20
> Unless they're in a very recent -linus. Probably this is a sign to test
> those patches. :-)

but I don't remember doing anything to the HTML generation part.
perhaps you need newer stylesheets?  I have docbook-xsl 1.68.1 here.

if the problem persists for you, could you hand me a copy of the
your stylesheet for testing?  It would be nice if kernel-doc would
work with more versions than mine ;-)

--=20
Martin Waitz

--NT59pYSnj1ZLVgEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcfosj/Eaxd/oD7IRAgQdAJ0f2RgMhVH1CSNzW2e+HGCycw258ACdHT+F
S7eBrvBcEgfMd6r+tq8ec5w=
=0agw
-----END PGP SIGNATURE-----

--NT59pYSnj1ZLVgEN--
