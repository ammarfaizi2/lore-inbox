Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUCCMrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCCMrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:47:31 -0500
Received: from grendel.firewall.com ([66.28.58.176]:43912 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261602AbUCCMmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:42:37 -0500
Date: Wed, 3 Mar 2004 13:42:29 +0100
From: Marek Habersack <grendel@caudium.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] with 2.4.25 - same on several machines
Message-ID: <20040303124229.GA1221@thanes.org>
Reply-To: grendel@caudium.net
References: <20040302223616.GA1439@thanes.org> <Pine.LNX.4.44.0403030719300.2537-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403030719300.2537-100000@dmt.cyclades>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2004 at 07:21:23AM -0300, Marcelo Tosatti scribbled:
[snip]
> > Mar  1 17:47:24 colo19 kernel:=20
> > Mar  1 17:47:24 colo19 kernel: Code: 8b 7d 08 ff 48 14 0f 94 c0 84 c0 7=
5 18 8b 5c 24 08 8b 74 24=20
> >=20
> > The processes in all cases were different (a shell script, lsof, apache=
).
> > The kernels are patched with grsec2 and libsata, but it doesn't seem to=
 be
> > relevant in this case. Could anybody shed some light on it? If necessar=
y, I
> > will post the machine configs and all the information needed to diagnos=
e.
>=20
> Hi Marek,=20
>=20
> <standard reply>
>=20
> Can you reproduce the problem on vanilla 2.4.25 ?=20
I'll try, it will probably take a while, at least till the weekend. The only
common pattern between the machines was the uptime - slightly above 36h. I
will be able to install 2.4.25 vanilla tomorrow, so I suppose Sunday at the
latest I will have some results.

thanks

marek

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARdK1q3909GIf5uoRAjh6AJ9TaStaqr3/nPHmHk460s90MxVbhQCdEjxC
q4Engp0nLgksY4y/LgLHZTY=
=gJxs
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
