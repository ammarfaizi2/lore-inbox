Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271276AbTGPXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271277AbTGPXxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:53:16 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:5008 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S271276AbTGPXxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:53:12 -0400
Date: Wed, 16 Jul 2003 20:08:04 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: David Ford <david+hb@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sound drivers?
Message-ID: <20030717000804.GT2412@rdlg.net>
Mail-Followup-To: David Ford <david+hb@blue-labs.org>,
	linux-kernel@vger.kernel.org
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net> <3F15E3C9.4030401@blue-labs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Content-Disposition: inline
In-Reply-To: <3F15E3C9.4030401@blue-labs.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



No go, it looks like it's playing but nothing to the speakers.

Thus spake David Ford (david+hb@blue-labs.org):

> /dev/sound/* is from OSS.  You'll have to enable OSS emulation if you=20
> want legacy apps to be able to use your sound.
>=20
> Alternatively, mpg123 --stdout | aplay, or similar.  Use a script or=20
> alias to make it easy on yourself.
>=20
> David
>=20
> Robert L. Harris wrote:
>=20
> >I do but the problem is I don't have a /dev/dsp, /dev/sound/dsp or
> >anything else to point mpg123 at.
> >
> >Thus spake Mike Fedyk (mfedyk@matchmail.com):
> >
> >=20
> >
> >>On Wed, Jul 16, 2003 at 06:58:26PM -0400, Robert L. Harris wrote:
> >>  =20
> >>
> >>>I have a soundblaster Live.  I've historically used the OSS drivers as
> >>>they've worked well for me.  I just tried to load the emu10k1 which
> >>>loads without error, but mpg123 says it can't open the default sound
> >>>device.
> >>>
> >>>Anyone able to do an lsmod or a listing of the drivers I need for an
> >>>SBLive?
> >>>    =20
> >>>
> >>Did you install alsa-utils?
> >>
> >

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Fejk8+1vMONE2jsRAjX5AKDYat0BJjV06WbGxCCzDibR2UcgkQCfV3tG
y8TVKgpKOMl6gHhHY6Ls/Xg=
=18NV
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
