Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTKFX2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTKFX2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:28:33 -0500
Received: from 24-216-47-96.charter.com ([24.216.47.96]:49024 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263857AbTKFX1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:27:14 -0500
Date: Thu, 6 Nov 2003 18:27:05 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: steve@drifthost.com
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: no DRQ after issuing WRITE
Message-ID: <20031106232705.GA844@rdlg.net>
Mail-Followup-To: steve@drifthost.com, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
References: <20031106032133.GD19875@rdlg.net> <Pine.LNX.4.10.10311052012260.28485-100000@master.linux-ide.org> <1796.61.88.244.7.1068096102.squirrel@mail.drifthost.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1796.61.88.244.7.1068096102.squirrel@mail.drifthost.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I went from 2.4.16 to 2.4.21-rc2-ac1.  Unfortunately the machines in
question are production and it'll be about 3 weeks of testing before I
can change them again.

Thus spake steve@drifthost.com (steve@drifthost.com):

> Well i only just started getting them and i started with 2.4.20 and
> upgraded to 2.4.21 about 6weeks or so ago (or when it came out)
>=20
> Started gettig errors about 4-5days ago..
>=20
> Ive seen alot of other ppl with the same error on early kernels..
>=20
> Any idea what it is
>=20
> >
> > I do not have time to pause and trace/fix the mess.
> > However if you both can kindly finger the last kernel when you did not
> > have this error, it will help constrain the pain.
> >
> > Cheers,
> >
> > Andre Hedrick
> > LAD Storage Consulting Group
> >
> > On Wed, 5 Nov 2003, Robert L. Harris wrote:
> >
> >>
> >>
> >> No answer for you but I've gotten this message also and was hoping
> >> someone would know what/why...
> >>
> >>
> >> Thus spake Steven Adams (steve@drifthost.com):
> >>
> >> > anyone?
> >> > ----- Original Message -----
> >> > From: <steve@drifthost.com>
> >> > To: <linux-kernel@vger.kernel.org>
> >> > Sent: Wednesday, November 05, 2003 2:05 PM
> >> > Subject: hda: no DRQ after issuing WRITE
> >> >
> >> >
> >> > > Hey guys,
> >> > >
> >> > > i keep getting things like this in my dmesg
> >> > >
> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > > hda: status timeout: status=3D0xd0 { Busy }
> >> > >
> >> > > hda: no DRQ after issuing WRITE
> >> > > ide0: reset: success
> >> > > hda: status timeout: status=3D0xd0 { Busy }
> >> > >
> >> > > hda: no DRQ after issuing WRITE
> >> > > ide0: reset: success
> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > >
> >> > > From hdparm
> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > > /dev/hda:
> >> > >
> >> > >  Model=3DIC35L080AVVA07-0, FwRev=3DVA4OA52A, SerialNo=3DVNC402A4CB=
RJLA
> >> Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >> > >  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D52
> >> > >  BuffType=3DDualPortCache, BuffSize=3D1863kB, MaxMultSect=3D16,
> >> MultSect=3Doff CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes,
> >> LBAsects=3D160836480 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120},
> >> tDMA=3D{min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
> >> > >  DMA modes:  mdma0 mdma1 mdma2
> >> > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
> >> > >  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
> >> > >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >> > >
> >> > > Ive searched high and low to try find out what this means, all ive
> >> found it people keep saying its all different kinds of things..
> >> > >
> >> > > I was wondering if this means my hdd is drying or is ti a setting?
> >> > >
> >> > > Thanks guys,
> >> > > Steve
> >> > >
> >> > >
> >> > > -
> >> > > To unsubscribe from this list: send the line "unsubscribe
> >> linux-kernel" in the body of a message to
> >> majordomo@vger.kernel.org
> >> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> >> >
> >> > -
> >> > To unsubscribe from this list: send the line "unsubscribe
> >> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >> :wq!
> >> ----------------------------------------------------------------------=
-----
> >> Robert L. Harris                     | GPG Key ID: E344DA3B
> >>                                          @ x-hkp://pgp.mit.edu
> >> DISCLAIMER:
> >>       These are MY OPINIONS ALONE.  I speak for no-one else.
> >>
> >> Life is not a destination, it's a journey.
> >>   Microsoft produces 15 car pileups on the highway.
> >>     Don't stop traffic to stand and gawk at the tragedy.
> >>
>=20
>=20
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

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/qtjJ8+1vMONE2jsRAlWlAKDm5xifY5khP7pYjcA5Eja+wBf9bgCgoVA0
eixXOaNTkW4YCHQ2t0hBI5A=
=NpUv
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
