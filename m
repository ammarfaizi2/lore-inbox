Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271255AbTGPX0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271257AbTGPX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:26:45 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:60303 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S271255AbTGPXZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:25:08 -0400
Date: Wed, 16 Jul 2003 19:39:56 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030716233956.GS2412@rdlg.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net> <3F15E1B5.4020206@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Content-Disposition: inline
In-Reply-To: <3F15E1B5.4020206@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



That's what I'm trying to do and why I'm trying to get the sound card to
work, it was in a previous part of this thread.  I'm trying to find out
what drivers to load how for ALSA with a soundblaster live.


Thus spake Jeff Garzik (jgarzik@pobox.com):

> Robert L. Harris wrote:
> >
> >I have a soundblaster Live.  I've historically used the OSS drivers as
> >they've worked well for me.  I just tried to load the emu10k1 which
> >loads without error, but mpg123 says it can't open the default sound
> >device.
>=20
>=20
> I am biased, but, it would be nice for people to start testing the=20
> "official" 2.6 sound drivers, ALSA.  The ALSA API has many benefits over=
=20
> OSS, but needs wide-spread testing and validation.
>=20
> 	Jeff, who is long tired of hacking on OSS drivers :)
>=20
>=20

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FeJM8+1vMONE2jsRAtFrAJ93nkKfZLBz5V57fDerMt9a555eEwCgsaft
z5tNFRBHlnZbY0Lc39qgbd8=
=rEgO
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--
