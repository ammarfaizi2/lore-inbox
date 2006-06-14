Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWFNNaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWFNNaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFNNaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:30:35 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:32427 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S964919AbWFNNad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:30:33 -0400
Date: Wed, 14 Jun 2006 15:30:22 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Daniel Phillips <phillips@google.com>
Cc: bidulock@openss7.org, Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614133022.GU11863@sunbeam.de.gnumonks.org>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+CNnuwY89phXYPb"
Content-Disposition: inline
In-Reply-To: <448F2A49.5020809@google.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--L+CNnuwY89phXYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2006 at 02:12:41PM -0700, Daniel Phillips wrote:
=20
> This has the makings of a nice stable internal kernel api.  Why do we want
> to provide this nice stable internal api to proprietary modules?

because there is IMHO legally nothing we can do about it anyway.  Use of
an industry-standard API that is provided in multiple operating system
is one of the clearest idnication of some program _not_ being a
derivative work.

Whether we like it or not, it doesn't really matter if we export them
GPL-only or not.  Anybody using those scoket API calls will be having an
easy time arguing in favor of non-derivative work.

The GPL doesn't extend beyon what copyright law allows you to do...

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--L+CNnuwY89phXYPb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEkA9uXaXGVTD0i/8RAgOCAKCCN5BPOQTrlPCqq0UMMUzqvk9UVgCfW9TA
f0mNqxFHpN9uwv5oUABcp+U=
=iHqi
-----END PGP SIGNATURE-----

--L+CNnuwY89phXYPb--
