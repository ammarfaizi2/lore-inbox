Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbTGQQGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271162AbTGQQGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:06:45 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:53213 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S271150AbTGQQGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:06:40 -0400
Subject: Re: 2.6 sound drivers?
From: Max Valdez <maxvalde@fis.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200307171308.54518.nbensa@gmx.net>
References: <20030716225826.GP2412@rdlg.net>
	 <200307162318.27081.nbensa@gmx.net> <wxx7k6h8f5n.fsf@nommo.uio.no>
	 <200307171308.54518.nbensa@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1Clc+W/8eFVJog0FDYVC"
Message-Id: <1058440959.3913.6.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 06:22:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1Clc+W/8eFVJog0FDYVC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have emu10k1 running over ALSA, but if i try to change bass or treble
with alsamixer, nothing changes on the output.

Max
On Thu, 2003-07-17 at 11:08, Norberto BENSA wrote:
> Terje Kvernes wrote:
> > Norberto BENSA <nbensa@gmx.net> writes:
> > > Last time I've checked ALSA, it didn't support bass and treble,
> > > that's why I'm using OSS (emu10k1)
> >
> >   I have treble and base support on my emu10k1 via ALSA.
>=20
> How could this be true if:
>=20
> Ian Hastie wrote:
> > ALSA's support seems usable, but still doesn't allow you to programme t=
he
> > DSP with your own code.  OSS uses this to enable such things as bass an=
d
> > treble controls, as well as a selection of audio effects with code
> > provided.  Anyone know if ALSA will allow this kind of thing in the fut=
ure?
>=20
> ???
>=20
> Anyone (Terje, Ed) care to say HOW did you enabled treble and bass in emu=
10k1=20
> (ALSA) or you will continuously say "it works for me" without saying anyt=
hing=20
> useful?
>=20
> Many thanks in advance,
> Norberto
--=20
Linux garaged 2.6.0-test1-ac1 #2 SMP Tue Jul 15 06:25:03 CDT 2003 i686 Pent=
ium III (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-1Clc+W/8eFVJog0FDYVC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Fob/srSE6THXcZwRAolsAJ4hoDL/a3M+05C5Bo3KAUTIOXpyzgCg7pBE
cLRyWCrplbUNv1vTSfSM+fw=
=wni0
-----END PGP SIGNATURE-----

--=-1Clc+W/8eFVJog0FDYVC--

