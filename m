Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVIFRLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVIFRLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVIFRLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:11:16 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:33500 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750758AbVIFRLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:11:15 -0400
Date: Tue, 6 Sep 2005 19:11:13 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050906171113.GI14984@sunbeam.de.gnumonks.org>
References: <20050904101218.GM4415@rama.de.gnumonks.org> <200509031627.00947.chase.venters@clientec.com> <20050904112032.GO4415@rama.de.gnumonks.org> <52k6huuq9d.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <52k6huuq9d.fsf@cisco.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2005 at 09:15:10AM -0700, Roland Dreier wrote:
>     Harald> Obviously, if HZ would ever go below 100, the code above
>     Harald> would provide some problems.  I'm not sure what the future
>     Harald> plans with HZ are, but I'll add an #error statement in
>     Harald> case HZ goes smaller than that.
>=20
> It might be simpler just to define it to msecs_to_jiffies(10).

That's what I did in the last version that was posted to lkml ;)

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHc2xXaXGVTD0i/8RAjUPAKCW6OY3x+9XCAaXVnfF1nQdPsTmzgCfYqtB
T/4ji4okhrblo4jZDvq0Dpc=
=oGLF
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
