Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266546AbUF0Dat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUF0Dat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 23:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267243AbUF0Dat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 23:30:49 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:62666 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266546AbUF0Dao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 23:30:44 -0400
Date: Sat, 26 Jun 2004 20:30:34 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>,
       stern@rowland.harvard.edu, david-b@pacbell.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
Message-ID: <20040627033034.GB10113@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
	arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
	linux-kernel@vger.kernel.org,
	USB Storage List <usb-storage@lists.one-eyed-alien.net>,
	stern@rowland.harvard.edu, david-b@pacbell.net, oliver@neukum.org
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <20040626201225.GA2149@one-eyed-alien.net> <20040626190827.7c919940@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20040626190827.7c919940@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 26, 2004 at 07:08:27PM -0700, Pete Zaitcev wrote:
> On Sat, 26 Jun 2004 13:12:25 -0700
> Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
>=20
> > Would I be correct in the following assessments:
> > (1) UB only supports direct-access type devices
> > (2) UB only supports 'transparent scsi' devices
> > (3) UB only supports 'bulk-only transport' devices
>=20
> Yes, you would. Someone mentioned on usb-storage list that Windows suppor=
ts
> two things only without extra drivers: Transparent SCSI over Bulk, and UF=
I.
> IIRC, it was Pat. So, I thought maybe to tackle drivers/block/ufi.c later,
> to share design concept and some libraries with ub. The rest stays with
> usb-storage. But the real life always introduces corrections to plans, so
> let's not get too far ahead.

Do you have a plan for non "direct-access" devices?

CD-ROMs are common, but tapes exist also.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Ye gods! I have feet??!
					-- Dust Puppy
User Friendly, 12/4/1997

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA3j9aIjReC7bSPZARAgwvAKCxbytSXfTTUKbqssB2Jn8GYXJPlACeMK9H
QukosUwVEYntYb5vzBh+ciU=
=GEav
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
