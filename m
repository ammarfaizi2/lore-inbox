Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSBVGie>; Fri, 22 Feb 2002 01:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292814AbSBVGiO>; Fri, 22 Feb 2002 01:38:14 -0500
Received: from think.faceprint.com ([166.90.149.11]:50567 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S288919AbSBVGiH>; Fri, 22 Feb 2002 01:38:07 -0500
Date: Fri, 22 Feb 2002 01:37:24 -0500
To: Dave Jones <davej@suse.de>, Benjamin Pharr <ben@benpharr.com>,
        linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020222063721.GA8879@faceprint.com>
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20020222022149.N5583@suse.de>
User-Agent: Mutt/1.3.27i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2002 at 02:21:49AM +0100, Dave Jones wrote:
>  > It compiled fine. When I booted up everything looked normal with the
>  > exception of a=20
>  > eth1: going OOM=20
>  > message that kept scrolling down the screen. My eth1 is a natsemi card.
>=20
>  That's interesting. Probably moreso for Manfred. I'll double check
>  I didn't goof merging the oom-handling patch tomorrow.

Ditto here on my natsemi.  It hasn't really spit out the error since
boot, about 12 hours ago.  Card has been mainly idle, only used to
connect via crossover cable to my laptop, which hasn't been used much in
that time.


--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dechPkYs3Ekt234RAvodAKC86wa39HPGi3l7krwZbCLxYvKO9QCfW6oh
X6U2+M3QnhJwfQeGe/eel6M=
=uOf+
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
