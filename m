Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWA2Nhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWA2Nhd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWA2Nhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:37:33 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:62951 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750983AbWA2Nhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:37:32 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Subject: Re: [PATCH] ahci: get JMicron JMB360 working
Date: Sun, 29 Jan 2006 14:43:48 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20060129050434.GA19047@havoc.gtf.org> <pan.2006.01.29.11.01.17.108084@tbdnetworks.com>
In-Reply-To: <pan.2006.01.29.11.01.17.108084@tbdnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1239875.nJYeblnhQx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601291443.48769.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1239875.nJYeblnhQx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag Januar 29 2006 12:01 schrieb Norbert Kiesel:
> On Sun, 29 Jan 2006 00:04:34 -0500, Jeff Garzik wrote:
> > I'll be sending this upstream sooner rather than later, since part of
> > this is a needed bugfix.  This is also a minor milestone:  the first
> > non-Intel AHCI implementation is working with the AHCI driver.  AHCI is
> > a nice SATA controller interface, and it's good to see other vendors
> > using it.  VIA is using it as well, and I hope to integrate a patch for
> > VIA AHCI SATA support soon.
> >
> > This patch, against latest 2.6.16-rc-git, adds support for JMicron and
> > fixes some code that should be Intel-only, but was being executed for
> > all vendors.
>
> Sounds very good, thanks! Does that mean the ASRock MB
> http://www.asrock.com/product/product_939Dual-SATA2.htm will work? Docu
> says "1 x SATA2 connector (based on PCI E SATA2 controller JMB360)".

Yes, I tested it a few hours ago.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1239875.nJYeblnhQx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD3MaUxU2n/+9+t5gRAm/qAJ9RRxLVBSF9tB9jR/ScVl61AToVBwCg1Z4G
RWrPm845aeql1rZ1aU8kEFw=
=48ul
-----END PGP SIGNATURE-----

--nextPart1239875.nJYeblnhQx--
