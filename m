Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWIGFrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWIGFrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 01:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWIGFrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 01:47:17 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:35391 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751923AbWIGFrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 01:47:16 -0400
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andi Kleen <ak@suse.de>
Cc: Piet Delaney <piet@bluelane.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
In-Reply-To: <200609062122.14971.ak@suse.de>
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
	 <m1k64hvsru.fsf@ebiederm.dsl.xmission.com>  <200609062122.14971.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-smH04EfIc5hifJ818ujJ"
Organization: Blue Lane Technologies
Date: Wed, 06 Sep 2006 22:47:11 -0700
Message-Id: <1157608031.14930.27.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 07 Sep 2006 05:47:15.0357 (UTC) FILETIME=[129C2CD0:01C6D241]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-smH04EfIc5hifJ818ujJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-06 at 21:22 +0200, Andi Kleen wrote:
> On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
> >=20
> > kexec has been marked experimental for a year now and all
> > of the serious problems have been worked through.  So it
> > is time (if not past time) to remove the experimental mark.
> >=20
>=20
> Hmm, I personally have some doubts it is really not experimental
> (not because of the kexec code itself, but because of all the other drive=
rs
> that still break)

What drivers does kexec break?

-piet

>=20
> But applied for now.
>=20
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Piet Delaney                                    Phone: (408) 200-5256
Blue Lane Technologies                          Fax:   (408) 200-5299
10450 Bubb Rd.
Cupertino, Ca. 95014                            Email: piet@bluelane.com

--=-smH04EfIc5hifJ818ujJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD4DBQBE/7JfJICwm/rv3hoRAkcFAJdpuzJeKh15RxBZV3aSnqYS6RFcAJ4u8REn
5nuUl9T2JcXi7uocMFgwFw==
=neu3
-----END PGP SIGNATURE-----

--=-smH04EfIc5hifJ818ujJ--

