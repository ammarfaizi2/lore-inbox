Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTIQKbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTIQKbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:31:17 -0400
Received: from ns.schottelius.org ([213.146.113.242]:30848 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S262680AbTIQKbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:31:13 -0400
Date: Wed, 17 Sep 2003 12:28:48 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 3com problems
Message-ID: <20030917102848.GC572@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20030916235104.GA27089@schottelius.org> <20030916164613.1d6ea7a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <20030916164613.1d6ea7a4.akpm@osdl.org>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test5
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Andrew Morton [Tue, Sep 16, 2003 at 04:46:13PM -0700]:
> Nico Schottelius <nico-kernel@schottelius.org> wrote:
> >
> > since using test2 the 3com cards 3c90x transfer _very_ slow.
> > this is reported by a friend a verified here.
> > 2.4.22 is fine.
> >=20
> > any changes in test3-test5?
>=20
> Some.   Try the 2.6.0-test2 3c59x.c in the 2.6.0-test5 kernel.

the problem is the system is a webserver and I cannot reboot it very often.
btw, why do you think this could help? Btw, I was wrong:
The system I use is test4 and not test2...
so I should try the test2 driver in test4, is that correct?

> If that's no good, try disabling ACPI.


no acpi is on.

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/aDdgzGnTqo0OJ6QRAgYKAJ9R///t57WvIZD2t4EHn70//ghZZQCgnSw4
iW0YB7fXyG9yUem1Ul2vQ2U=
=nTid
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
