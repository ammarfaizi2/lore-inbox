Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTJ3XwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTJ3XwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:52:10 -0500
Received: from ns.suse.de ([195.135.220.2]:59091 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262989AbTJ3XwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:52:06 -0500
Date: Fri, 31 Oct 2003 00:52:04 +0100
From: Kurt Garloff <garloff@suse.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031030235204.GF2716@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org,
	Matthias Andree <matthias.andree@gmx.de>
References: <Pine.LNX.4.44.0310262035270.3346-100000@poirot.grange> <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guennadi,

Great!

On Thu, Oct 30, 2003 at 11:12:57PM +0100, Guennadi Liakhovetski wrote:
> Ok, I fixed it, well, at least, it works for me. What now? The fix is,
> probably, not perfect. E.g. it doesn't support multiple cards now, but it
> looks like the driver didn't support them even when it worked in its
> latest version (sorry, if I am wrong).
>=20
> Patch attached. Comments / improvement suggestions mostly welcome.

I think it should just be merged; Christoph will certainly find places
to criticize ... but that's the way the stuff gets better.

Interested in taking tmscsim as well?
I promised to port it, and I will, but it won't happen during the next=20
ten days :-(

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/oaQkxmLh6hyYd04RAjb6AJkBohpJrvrPpCAITjCgKn1s3NS58ACg2nRH
8YGRdaFi/d0YUdBzqOGCP/Q=
=nG1f
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
