Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbVIPOHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbVIPOHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 10:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbVIPOHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 10:07:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161099AbVIPOHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 10:07:40 -0400
Subject: Re: best way to access device driver functions
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, ivan.korzakow@gmail.com,
       fawadlateef@gmail.com
In-Reply-To: <87mzmduq1h.fsf@amaterasu.srvr.nix>
References: <a5986103050915004846d05841@mail.gmail.com>
	 <1e62d137050915010361d10139@mail.gmail.com>
	 <a598610305091505184a8aa8fd@mail.gmail.com>
	 <1e62d13705091508391832f897@mail.gmail.com>
	 <87mzmduq1h.fsf@amaterasu.srvr.nix>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XTEPud95lvgNBkVm3lhE"
Organization: Red Hat, Inc.
Date: Fri, 16 Sep 2005 10:07:40 -0400
Message-Id: <1126879660.3103.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XTEPud95lvgNBkVm3lhE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> New *system calls* are generally avoided (especially if they might be
> useful to non-privileged code) because they come with a *very* high
> backward compatibility burden

ioctls come with the same burden though.


--=-XTEPud95lvgNBkVm3lhE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKtGspv2rCoFn+CIRAvhvAKCJ/1Q0UbfZZwh+xb3ogU4emXTaOACaAkp2
KOslXHbgqNMxv19LTNqKUFc=
=Uxed
-----END PGP SIGNATURE-----

--=-XTEPud95lvgNBkVm3lhE--

