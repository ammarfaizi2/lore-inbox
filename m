Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbTGPXQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271255AbTGPXQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:16:12 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:54159 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S271223AbTGPXPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:15:54 -0400
Date: Wed, 16 Jul 2003 19:30:45 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030716233045.GR2412@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Content-Disposition: inline
In-Reply-To: <20030716231029.GG1821@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I do but the problem is I don't have a /dev/dsp, /dev/sound/dsp or
anything else to point mpg123 at.

Thus spake Mike Fedyk (mfedyk@matchmail.com):

> On Wed, Jul 16, 2003 at 06:58:26PM -0400, Robert L. Harris wrote:
> >=20
> >=20
> > I have a soundblaster Live.  I've historically used the OSS drivers as
> > they've worked well for me.  I just tried to load the emu10k1 which
> > loads without error, but mpg123 says it can't open the default sound
> > device.
> >=20
> > Anyone able to do an lsmod or a listing of the drivers I need for an
> > SBLive?
>=20
> Did you install alsa-utils?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FeAl8+1vMONE2jsRApivAKDo24MFaXsoYqY2UgBWKVBMibw/hwCfTFn+
pQ1NGV8DzHBEdAvgQ0sJ1ew=
=Rism
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
