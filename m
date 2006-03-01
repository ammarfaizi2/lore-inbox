Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWCATCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWCATCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCATCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:02:31 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:52693 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932410AbWCATCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:02:30 -0500
Subject: Re: LibPATA code issues / 2.6.15.4
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: edmudama@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bd/DHLecUGJAzjJnvX5E"
Organization: Adresse perso
Date: Wed, 01 Mar 2006 20:00:16 +0100
Message-Id: <1141239617.23202.5.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bd/DHLecUGJAzjJnvX5E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> those drives should support all FUA opcodes properly, both queued and unq=
ueued
>=20
> On 2/28/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Mark Lord wrote:
> > > David Greaves wrote:
> > >
> > >>
> > >> scsi1 : sata_sil
> > >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> > >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> > >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> > >>   Type:   Direct-Access                      ANSI SCSI revision: 05

How about the drives that got blacklisted following :
http://bugzilla.kernel.org/show_bug.cgi?id=3D5914 ?
and
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D177951 ?

Device Model:     Maxtor 6L300S0
Firmware Version: BANC1G10

on

Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev=
 02)

Regards,

--=20
Nicolas Mailhot

--=-bd/DHLecUGJAzjJnvX5E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iEYEABECAAYFAkQF70AACgkQI2bVKDsp8g1V2gCdHxLLMS7Dyt0YcZ4lVLS6TzH6
1/cAoMO3bnWEIDLPAzmWcg5b2HPTC2c4
=SwOE
-----END PGP SIGNATURE-----

--=-bd/DHLecUGJAzjJnvX5E--

