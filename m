Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWAGSBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWAGSBv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbWAGSBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:01:50 -0500
Received: from mail.gmx.de ([213.165.64.21]:31960 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030521AbWAGSBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:01:50 -0500
X-Authenticated: #24128601
Date: Sat, 7 Jan 2006 19:02:11 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: Brad Campbell <brad@wasp.net.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107180211.GA12209@section_eight.mops.rwth-aachen.de>
References: <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de> <43BFFE08.70808@wasp.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <43BFFE08.70808@wasp.net.au>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please, don't forget to me and axboe@suse.de)

On Sa, Jan 07, 2006 at 09:44:40 +0400, Brad Campbell wrote:
> Sebastian wrote:
> >
> >Yay, problem solved!
> >
>=20
>=20
> >
> >P.S.: I already reripped the test disc using ide-cd and the
> >SG_IO-patched cdparanoia and the results are perfect. OMG, I bought Win
> >XP Home 2 months ago because of this (so I can use Exact Audio Copy). I
> >guess I can remove XP from my drive now and sell it to some wretched guy=
 :)
> >Harhar.
> >
> >S.
>=20
> Yes, but now we need to find out why one interface fails while another=20
> works.. I have the same problem here using cdrdao when ripping entire dis=
k=20
> images. I'd love to fix the real issue rather than work around it by havi=
ng=20
> userspace use another interface.
> I would have thought that both interfaces should return the same data..
>=20
> Brad

I think cdrdao can use SG_IO if you tell it to. Check their documentation. =
Or did I misunderstand what you're saying?

Sebastian

--=20
"When the going gets weird, the weird turn pro." (HST)

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwAIjTWouIrjrWo4RAgIdAJ9rdTKHNv4KvgrMZZvW5At0FUgLcgCffD6w
m2KMYKcCT9c96BDJXy8clUo=
=gIn+
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

