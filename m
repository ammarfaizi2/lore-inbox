Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291397AbSBSNcZ>; Tue, 19 Feb 2002 08:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSBSNcP>; Tue, 19 Feb 2002 08:32:15 -0500
Received: from fysh.org ([212.47.68.126]:8460 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S291397AbSBSNcI>;
	Tue, 19 Feb 2002 08:32:08 -0500
Date: Tue, 19 Feb 2002 13:32:07 +0000
From: Athanasius <Athanasius@gurus.tf>
To: Advisories <advisories@stelt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rc1 freezing while switching to console
Message-ID: <20020219133207.GO31110@gurus.tf>
Mail-Followup-To: Athanasius <Athanasius@gurus.tf>,
	Advisories <advisories@stelt.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <73925952749.20020219154004@stelt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <73925952749.20020219154004@stelt.ru>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2002 at 03:40:04PM +0300, Advisories wrote:
> Tested system:
> CPU:   AMD Duron 700
> MB:    GA-7ZM
> RAM:   256Mb
> VIDEO: nVidia TNT AGP
>=20
> kernel 2.4.18-rc1 with same configuration
>=20
> system started, X login message diplayed
> when pressed Ctrl+Alt+F1 system freeze with blank screen :(
> only _reset_ can help

   You don't mention if you use FrameBuffer or plain text console.  I
used FB with a GF2MX400 for a while and encountered this same problem
(in various 2.4.17/2.4.18-pre's), so went back to plain text as I spend
most of my time in X11 anyway.  All FB gained me was Tux at boot-time
*;-).

-Ath
--=20
- Athanasius =3D Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjxyU9YACgkQzbc+I5XfxKdIpgCeKIFM3S9X8WghRMQC653f9D6s
VCEAn35ceog8OLkI86I16dRo2NJxkNmd
=4DBW
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--
