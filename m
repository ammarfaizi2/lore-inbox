Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUCMR0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUCMR0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:26:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263130AbUCMR0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:26:38 -0500
Subject: Re: finding out the value of HZ from userspace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Micha Feigin <michf@post.tau.ac.il>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040311141703.GE3053@luna.mooo.com>
References: <20040311141703.GE3053@luna.mooo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NPGLn1kdAP7HSy50xpOk"
Organization: Red Hat, Inc.
Message-Id: <1079198671.4446.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 13 Mar 2004 18:24:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NPGLn1kdAP7HSy50xpOk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> Is it possible to find out what the kernel's notion of HZ is from user
> space?
> It seem to change from system to system and between 2.4 (100 on i386)
> to 2.6 (1000 on i386).

if you can see 1000 from userspace that is a bad kernel bug; can you say
where you find something in units of 1000 ?

--=-NPGLn1kdAP7HSy50xpOk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQBAU0PPxULwo51rQBIRAtBWAJ9p6pyFMtuEifJ+PenkjM66R3jSkQCXXUPG
okQoj6reGqGXK0LAHi9ZrQ==
=NeQV
-----END PGP SIGNATURE-----

--=-NPGLn1kdAP7HSy50xpOk--

