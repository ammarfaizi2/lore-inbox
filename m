Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTFUUvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTFUUvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:51:22 -0400
Received: from tehunlose.com ([68.15.181.213]:1967 "EHLO
	cerebellum.tehunlose.com") by vger.kernel.org with ESMTP
	id S265337AbTFUUvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:51:19 -0400
From: Zack Gilburd <zack@tehunlose.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7(censored) card gone wild?
Date: Sat, 21 Jun 2003 14:05:23 -0700
User-Agent: KMail/1.5.2
References: <A46BBDB345A7D5118EC90002A5072C780E040C95@orsmsx116.jf.intel.com> <20030621094748.GB4560@merlin.emma.line.org>
In-Reply-To: <20030621094748.GB4560@merlin.emma.line.org>
MIME-Version: 1.0
Message-Id: <200306211335.48734.zack@tehunlose.com>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_TiM9+wrPlIKXRH2";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_TiM9+wrPlIKXRH2
Content-Type: multipart/mixed;
  boundary="Boundary-01=_TiM9+fz6aDkG2p4"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_TiM9+fz6aDkG2p4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

On Saturday 21 June 2003 02:47, Matthias Andree wrote:
> On Fri, 20 Jun 2003, Perez-Gonzalez, Inaky wrote:
> > So I wonder, what does that error mean? SCSI1 has attached a
> > CDRW (Sony Yamaha CDRW 8/4/24) but now it doesn't show up
> > anymore (and so, I cannot get the model). .
>
> The first step towards finding that out is power cycling (shut down,
> switch off for a minute, then start up again) or physically
> disconnecting the Yamaha drive (if it's Yamaha).
>
> I've seen Adaptecs fuss and fight with Yamahas more than once --
> although in Linux 2.2 and early 2.4 times -- and Yamahas have the nasty
> habit of locking up until the next power cycle when something goes
> wrong.
>
> > Could it mean by SCSI Adapter is hosed? or my CDRW drive?
>
> It might be either, I'd suspect the CDRW first unless I had information
> that suggests otherwise.
>
> Try to find out.

The aic7xxx has been driving me crazy in 2.5.7x... Something got changed an=
d=20
now the card will not work for me.  I've posted the errors to this ML, but=
=20
noone replied.. You can dig for the message, if you'd like.  It's the only=
=20
other time I've posted to the LKML.

=2D-=20
Zack Gilburd
http://tehunlose.com



--Boundary-01=_TiM9+fz6aDkG2p4
Content-Type: application/pgp-signature;
  name=" "
Content-Transfer-Encoding: 7bit
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9MGkp5pFZoJAq2wRAveSAJ0diPDsEutuTxOhvv4c0/sFKIf+VgCfRtfl
cWo1BTigvzAnMck3X4T1d+w=
=VfuC
-----END PGP SIGNATURE-----

--Boundary-01=_TiM9+fz6aDkG2p4--

--Boundary-03=_TiM9+wrPlIKXRH2
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9MiTp5pFZoJAq2wRAojZAJ4/BKzm3fofEftJrmSHZxsZl424FQCfR7pv
qBvWDnE1dFBS88chF69lXtk=
=5iDx
-----END PGP SIGNATURE-----

--Boundary-03=_TiM9+wrPlIKXRH2--

