Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268311AbTAMTku>; Mon, 13 Jan 2003 14:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268310AbTAMTkt>; Mon, 13 Jan 2003 14:40:49 -0500
Received: from dialin-145-254-148-171.arcor-ip.net ([145.254.148.171]:64386
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S268307AbTAMTks>; Mon, 13 Jan 2003 14:40:48 -0500
Date: Mon, 13 Jan 2003 20:47:50 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.56] (partial known) bugs/compile errors
Message-ID: <20030113194750.GB330@schottelius.org>
References: <20030113090200.GA1096@schottelius.org> <20030113190105.GA8394@kroah.com> <20030113193401.GA330@schottelius.org> <20030113194109.GD8394@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20030113194109.GD8394@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.54
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg KH [Mon, Jan 13, 2003 at 11:41:09AM -0800]:
> On Mon, Jan 13, 2003 at 08:34:01PM +0100, Nico Schottelius wrote:
> > Greg KH [Mon, Jan 13, 2003 at 11:01:06AM -0800]:
> > > On Mon, Jan 13, 2003 at 10:02:00AM +0100, Nico Schottelius wrote:
> > > > WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unk=
nown symbol usb_bus_list_lock
> > > > WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unk=
nown symbol usb_bus_list
> > >=20
> > > Do you have CONFIG_USB selected in your .config?
> >=20
> > yes, but all usb things are modularized
>=20
> And what is your CONFIG_SECURITY_* options?

for further questions: i attached .config.

Nico

p.s.: currently I am trying to update module-init-tools...if that helps..


--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+IxfmtnlUggLJsX0RAsvFAKCGt+UwTlP8AGI+J1EduRBXpmOJOwCeL3tB
nVlPWA8fNIGh6aENbIAXoAY=
=zg7u
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
