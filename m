Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTKFDVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 22:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTKFDVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 22:21:39 -0500
Received: from 24-216-47-96.charter.com ([24.216.47.96]:18862 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263312AbTKFDVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 22:21:36 -0500
Date: Wed, 5 Nov 2003 22:21:33 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Steven Adams <steve@drifthost.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no DRQ after issuing WRITE
Message-ID: <20031106032133.GD19875@rdlg.net>
Mail-Followup-To: Steven Adams <steve@drifthost.com>,
	linux-kernel@vger.kernel.org
References: <200311042029.38749.andy@asjohnson.com> <1805.61.88.244.7.1068001546.squirrel@mail.drifthost.com> <01ba01c3a3f7$1da22100$dfb21ad3@drifthost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <01ba01c3a3f7$1da22100$dfb21ad3@drifthost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



No answer for you but I've gotten this message also and was hoping
someone would know what/why...


Thus spake Steven Adams (steve@drifthost.com):

> anyone?
> ----- Original Message -----=20
> From: <steve@drifthost.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, November 05, 2003 2:05 PM
> Subject: hda: no DRQ after issuing WRITE
>=20
>=20
> > Hey guys,
> >
> > i keep getting things like this in my dmesg
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > hda: status timeout: status=3D0xd0 { Busy }
> >
> > hda: no DRQ after issuing WRITE
> > ide0: reset: success
> > hda: status timeout: status=3D0xd0 { Busy }
> >
> > hda: no DRQ after issuing WRITE
> > ide0: reset: success
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > From hdparm
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > /dev/hda:
> >
> >  Model=3DIC35L080AVVA07-0, FwRev=3DVA4OA52A, SerialNo=3DVNC402A4CBRJLA
> >  Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D52
> >  BuffType=3DDualPortCache, BuffSize=3D1863kB, MaxMultSect=3D16, MultSec=
t=3Doff
> >  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D16083=
6480
> >  IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> >  DMA modes:  mdma0 mdma1 mdma2
> >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
> >  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
> >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > Ive searched high and low to try find out what this means, all ive found
> > it people keep saying its all different kinds of things..
> >
> > I was wondering if this means my hdd is drying or is ti a setting?
> >
> > Thanks guys,
> > Steve
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/qb498+1vMONE2jsRAg6KAJ4mGQrj0fw6JJMUSwO041xNOPtSNgCfTYlD
D+rCz0lZK+uXTuVNhdSDIm0=
=S6eo
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
