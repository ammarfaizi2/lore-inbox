Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWHHOsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWHHOsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWHHOsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:48:13 -0400
Received: from nemesis.fprintf.net ([66.134.112.218]:50953 "EHLO
	nemesis.fprintf.net") by vger.kernel.org with ESMTP id S932588AbWHHOsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:48:10 -0400
Subject: Re: [uml-devel] [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
From: Daniel Gryniewicz <dang@gentoo.org>
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: Andi Kleen <ak@suse.de>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
References: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RKeyaclj8y0JuO9SU+mU"
Date: Tue, 08 Aug 2006 10:47:55 -0400
Message-Id: <1155048476.18932.17.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.90 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RKeyaclj8y0JuO9SU+mU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-08 at 16:03 +0200, Paolo Giarrusso wrote:

> Moreover, who has recently tested module loading in x86-64 uml
> kernels? I don't remember doing such testing recently...
>=20

Well, modules seem to work fine here on x86_64.  I'm running 2.6.16-bs2.
I only tested the loop module, but others also load.

Daniel

--=-RKeyaclj8y0JuO9SU+mU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5-ecc0.1.6 (GNU/Linux)

iD8DBQBE2KQbomPajV0RnrERAkXUAJsE5WuxR6pv/6HWpiqPHW6YBrslLACdG7Mt
17BpCawE+f9pLrN0nE3gNX4=
=Pohy
-----END PGP SIGNATURE-----

--=-RKeyaclj8y0JuO9SU+mU--

