Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUBJOsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbUBJOsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:48:10 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:19075 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265908AbUBJOrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:47:53 -0500
Subject: Re: Kernel Fault 2.4.20
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402100936050.16491@puma.cabm.rutgers.edu>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
	 <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
	 <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0402100936050.16491@puma.cabm.rutgers.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rYZjWQXySvC/+KId8sEA"
Organization: Red Hat, Inc.
Message-Id: <1076424458.4442.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 10 Feb 2004 15:47:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rYZjWQXySvC/+KId8sEA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-10 at 15:41, Ananda Bhattacharya wrote:
> There was a kernel fault today, I am not quite sure what=20
> just happened, if anyone has any ideas and can point me in=20
> the right direction.
> Thanks a lot=20

try using tg3 instead of bcm5700... something in networking oopsed



--=-rYZjWQXySvC/+KId8sEA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAKO8KxULwo51rQBIRAkcDAJ9UnlhfkeDtrCRbJdhr309ZP0+j4QCgqX2r
nIVjevAafqMz2dXb4sGFbnQ=
=lKZJ
-----END PGP SIGNATURE-----

--=-rYZjWQXySvC/+KId8sEA--
