Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVH3NGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVH3NGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVH3NGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:06:48 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:15004 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751262AbVH3NGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:06:47 -0400
Date: Tue, 30 Aug 2005 14:56:49 +0200
From: Harald Welte <laforge@gpl-violations.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050830125648.GG4295@rama.de.gnumonks.org>
References: <20050830085522.GA8820@midnight.suse.cz> <20050830101958.GJ4202@rama.de.gnumonks.org> <20050830121810.GA11582@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20050830121810.GA11582@midnight.suse.cz>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 02:18:10PM +0200, Vojtech Pavlik wrote:
=20
> > If it is from the ASUS, what makes you think that the D-Link runs the
> > same OS?  It is quite often the case that one chipset design has
> > multiple operating systems ported to it (you see systems with the same
> > broadcom or Intersil chipset, one running Linux, the other VxWorks).
>=20
> > Please indicate how you came to the conclusion that the D-Link really
> > runs Linux.
>=20
> The device's ESSID during boot is 'Marvell AP-32', and the Libertas
> AP-32 and AP-52 design toolkits contain only ports of Linux and eCos to
> the device, according to Marvell. Considering the device's routing
> capabilities I'm believe it's running Linux, but I don't have a solid
> proof yet, unfortunately. The eCos port is intended for the non-router
> variety of the design.

There could also be a 3rd party toolkit with a different OS that you
don't know about...

> On the other hand, eCos seems to be GPL, too, although it's possible
> that the owner dual-licenses it.

According to http://sources.redhat.com/ecos/, it is either still RedHat
or already transferred to the FSF.  That doesn't sound like dual
licensing, I don't think the FSF would do that...

> > > A firmware image is available from D-Link
> > > and it seems to be composed of compressed blocks padded by zeroes. I =
haven't
> > > verified yet that it's indeed a compressed kernel, cramfs, etc, but i=
t seems
> > > quite likely.
> >=20
> > I'm downloading it right now, and I'll see whether I can find any Linux
> > in there.
>=20
> Good luck. I'll try to take a look, too.

Up to now I can only tell you that it doesn't look like any of the 50+
linux firmware images I've seen so far.

> > Sure, it's (unfortunately) not the first time I'm dealing with D-Link on
> > their GPL [in]compliance :((
>=20
> Rather unrelated, I'm trying to figure out what to do with Elo
> Touchsystems, they used my HID driver as a base of their own binary-only
> driver and don't answer to e-mail.

Well, if you seriously want to do something about it: They have a German
subsidiary.  So if the respective product can be bought through that .de
office, we can do something about it here.  Let's take this offline.

--=20
- Harald Welte <laforge@gpl-violations.org>       http://gpl-violations.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFFeQXaXGVTD0i/8RAupkAJ0VNnTAXkM7F/3IXxp2qHyn9391LgCfW7kU
a2HRPliy3OlOYtyqjJLRUfE=
=0FYR
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
