Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130028AbQJ0BWK>; Thu, 26 Oct 2000 21:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129938AbQJ0BWB>; Thu, 26 Oct 2000 21:22:01 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:62479
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S130028AbQJ0BVj>;
	Thu, 26 Oct 2000 21:21:39 -0400
Date: Thu, 26 Oct 2000 18:21:37 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
Subject: Re: [PATCH] address-space identification for /proc
Message-ID: <20001026182137.A31159@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
In-Reply-To: <20001026154527.A30463@goop.org> <20001026155225.B30463@goop.org> <20001026190126.E28472@sventech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001026190126.E28472@sventech.com>; from johannes@erdfelt.com on Thu, Oct 26, 2000 at 07:01:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2000 at 07:01:26PM -0400, Johannes Erdfelt wrote:
> and even more obvious:
>=20
> +	buffer +=3D sprintf(buffer, "ASID:\t%p\n", mm);
>=20
> Actually putting it into the buffer would be useful as well :)

That serves me right for hand-editing patches.

	J
--
Repeat to self: I am not Linus

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjn42KEACgkQf6p1nWJ6IgKCIgCdGiEZ8homEHJ7sEK8BAxAm5QV
ggQAn17XszXbn8xoshWveq2H1yFEzU4T
=esBN
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
