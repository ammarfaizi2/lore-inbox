Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUF3DSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUF3DSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 23:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUF3DSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 23:18:14 -0400
Received: from smtp.golden.net ([199.166.210.31]:1551 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S266249AbUF3DSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 23:18:08 -0400
Date: Tue, 29 Jun 2004 23:17:55 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Eric Lammerts <eric@lammerts.org>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asiliantfb fixes
Message-ID: <20040630031755.GF29025@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Eric Lammerts <eric@lammerts.org>, jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0406292217520.5837@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406292217520.5837@ally.lammerts.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2004 at 10:41:12PM -0400, Eric Lammerts wrote:
> this patch fixes the asiliantfb driver. A call to the init function
> was missing so it was never actually used. The other fix is in the
> init function writing somewhere using a physical address instead of a
> virtual address.
>=20
The asiliantfb_init() stuff is already fixed in current BK.


--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4jDj1K+teJFxZ9wRAqmXAKCCpEiB5H57H9ZCpwQkAlXA8iVF1ACbBn7+
Lz1CS7x6CE5vSZfbiIBAp4Y=
=dTgf
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
