Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbTHZQOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTHZQOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:14:20 -0400
Received: from [24.241.190.29] ([24.241.190.29]:30664 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262895AbTHZQON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:14:13 -0400
Date: Tue, 26 Aug 2003 12:14:09 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where'd my second proc go?
Message-ID: <20030826161409.GW16183@rdlg.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030826151225.GT16183@rdlg.net> <Pine.LNX.4.53.0308261124200.6876@montezuma.fsmlabs.com> <20030826154343.GU16183@rdlg.net> <Pine.LNX.4.53.0308261207180.6876@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/T7Ys/vy2qfZwzBO"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308261207180.6876@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/T7Ys/vy2qfZwzBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thus spake Zwane Mwaikambo (zwane@linuxpower.ca):

> On Tue, 26 Aug 2003, Robert L. Harris wrote:
>=20
> > Thus spake Zwane Mwaikambo (zwane@linuxpower.ca):
> >=20
> > > On Tue, 26 Aug 2003, Robert L. Harris wrote:
> > >=20
> > > >=20
> > > >=20
> > > > Dual-P3-850.  Bios reports both procs.  2.4.21-ac3 reported both pr=
ocs.
> > > > 2.4.22-rc2-ac1 only shows one.  The lilo used to have a "maxcpus=3D=
1"
> > > > append but I removed that and I tried changing it to 4 even.  cat
> > > > /proc/cpu only shows 1 still.
> > >=20
> > > dmesg?
>=20
> It looks strange, can you boot with 'debug' kernel parameter and send the=
=20
> entire /var/log/dmesg
>=20
> Thanks

I'll try and get a window, this is a production box so I can't keep
rebooting it.  just put 'append=3D"debug"' in the lilo.conf and reboot?
(headless server)

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--/T7Ys/vy2qfZwzBO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/S4dR8+1vMONE2jsRAvVDAJ9SJBNCrD+5lyClavEtV09MiiNzoACghIpj
omEgM/+g7I+1+8St5hPtWgQ=
=pY4t
-----END PGP SIGNATURE-----

--/T7Ys/vy2qfZwzBO--
