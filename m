Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311864AbSCTRVY>; Wed, 20 Mar 2002 12:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311865AbSCTRVO>; Wed, 20 Mar 2002 12:21:14 -0500
Received: from runyon.sfbay.redhat.com ([205.180.230.5]:43739 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S311864AbSCTRVC>;
	Wed, 20 Mar 2002 12:21:02 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
From: Ulrich Drepper <drepper@redhat.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, martin.wirth@dlr.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C9867AA.8070008@loewe-komp.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-qWV3M68KC/dy/n/9fEZY"
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 20 Mar 2002 09:20:53 -0800
Message-Id: <1016644853.2393.54.camel@myware.mynet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qWV3M68KC/dy/n/9fEZY
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-03-20 at 02:42, Peter W=E4chtler wrote:

> Well, mutexes are not semaphores. Why not have fusema or fuma?
> They are good for thread pools where you want several workers.

I have absolutely no objections whatsoever to get semaphore support in
the kernel.  It would be much more efficient in some situations and the
basic infrastructures is already there.  If you can convince the powers
there are to accept such a patch I'm all for it.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-qWV3M68KC/dy/n/9fEZY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8mMT02ijCOnn/RHQRAtjmAJ41WgP5Lcw9UlpZ17/4tX4SAnYuEQCZAcHq
+xA84L7os/KI2hr+/r4ezY4=
=SZFz
-----END PGP SIGNATURE-----

--=-qWV3M68KC/dy/n/9fEZY--

