Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUCDS5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCDS4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:56:55 -0500
Received: from wblv-248-49.telkomadsl.co.za ([165.165.248.49]:13697 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262082AbUCDSyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:54:41 -0500
Subject: Re: [ANNOUNCE] udev 021 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040304184602.GI13907@kroah.com>
References: <20040303000957.GA11755@kroah.com>
	 <1078422507.3614.20.camel@nosferatu.lan> <20040304184602.GI13907@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HH+fcxMQnI2tv9c4ldht"
Message-Id: <1078426567.3614.24.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 20:56:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HH+fcxMQnI2tv9c4ldht
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-04 at 20:46, Greg KH wrote:
> On Thu, Mar 04, 2004 at 07:48:27PM +0200, Martin Schlemmer wrote:
> > On Wed, 2004-03-03 at 02:09, Greg KH wrote:
> > > I've released the 021 version of udev.  It can be found at:
> > >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz
> > >=20
> >=20
> > Is the issue that causes missing events with udevsend (and udev in
> > some cases - like alsa and it seems the -mm tree) with slower machines
> > known yet?
>=20
> No, this is not really known.  I've heard rumors of it, but been unable
> to duplicate it here.   Some solid error reports would be greatly
> appreciated...
>=20

Besides reports from others, my work box also shows this - they just do
not endorse (and don't want to find out if they will mind) me doing
work in this field.  I will however try to track or get some type of
test case.


--=20
Martin Schlemmer

--=-HH+fcxMQnI2tv9c4ldht
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAR3vHqburzKaJYLYRArBWAJ4xH/HXCZTce/PIrYSfGZJbxIG0SQCfYEr1
J4Husc3vlCVeXdfHr/uYq6U=
=oEro
-----END PGP SIGNATURE-----

--=-HH+fcxMQnI2tv9c4ldht--

