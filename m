Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289735AbSAJWYt>; Thu, 10 Jan 2002 17:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289736AbSAJWYj>; Thu, 10 Jan 2002 17:24:39 -0500
Received: from h24-71-138-152.ss.shawcable.net ([24.71.138.152]:64504 "HELO
	lorien.untroubled.org") by vger.kernel.org with SMTP
	id <S289737AbSAJWYZ>; Thu, 10 Jan 2002 17:24:25 -0500
Date: Thu, 10 Jan 2002 16:24:45 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Where's all my memory going?
Message-ID: <20020110162445.A13236@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int> <20020110145542.B2499@mould.bodgit-n-scarper.com> <20020110134657.A26688@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020110134657.A26688@lynx.adilger.int>; from adilger@turbolabs.com on Thu, Jan 10, 2002 at 01:46:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2002 at 01:46:57PM -0700, Andreas Dilger wrote:
> One question - what happens to the emails after they are delivered?  Are
> they kept on the local filesystem?

Messages in the queue are deleted after delivery (of course).  Messages
delivered locally are stored on the local filesystem until they're
picked up by POP (typically within 15 minutes).
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8PhSt6W+y3GmZgOgRAloTAJ43laDzalfME5y3XFkySUbDHKDjJgCgnCNG
HlFwtBpQibVb9++hxcNqqEU=
=KYny
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
