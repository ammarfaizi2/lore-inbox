Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUADV24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUADV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:28:55 -0500
Received: from coruscant.franken.de ([193.174.159.226]:27286 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264453AbUADV2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:28:54 -0500
Date: Sun, 4 Jan 2004 21:32:55 +0100
From: Harald Welte <laforge@netfilter.org>
To: linux-kernel@vger.kernel.org
Cc: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Does CONFIG_NET_FASTROUTE conflict with CONFIG_NETFILTER?
Message-ID: <20040104203255.GC830@obroa-skai.de.gnumonks.org>
References: <20040104111154.GN1882@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20040104111154.GN1882@matchmail.com>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.0-test11
X-Date: Today is Prickle-Prickle, the 4th day of Chaos in the YOLD 3170
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 04, 2004 at 03:11:54AM -0800, Mike Fedyk wrote:
> If they do, then the config system should not allow you to enable both at
> the same time.

They don't conflict.   It should compile quite fine, but you cannot use
both of them at the same time.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+Hh3XaXGVTD0i/8RAgV3AKCLd2FjCp1WRVofA73VJMLItU3/UQCfZSVz
Qxds+OvpOj/DfRpSCTm0SUY=
=+EGL
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
