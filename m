Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVEVL1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVEVL1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 07:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVEVL1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 07:27:14 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:6334 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261788AbVEVL0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 07:26:51 -0400
Subject: Re: pm_message_t fix for radeon_pm.c
From: Henrik Brix Andersen <brix@gentoo.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050522105050.GA3685@elf.ucw.cz>
References: <1116669744.14475.7.camel@sponge.fungus>
	 <20050522105050.GA3685@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yBqBO2uoUIn7uh5g8MHY"
Organization: Gentoo Linux
Date: Sun, 22 May 2005 13:26:47 +0200
Message-Id: <1116761207.13335.1.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yBqBO2uoUIn7uh5g8MHY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sun, 2005-05-22 at 12:50 +0200, Pavel Machek wrote:
> Are you sure? I think you'll _break_ compilation by doing
> this. pm_message_t becoming struct is not yet merged in rc4, IIRC.

Argh - I suffered from patchset-confusion-disorder there for a moment, I
apologize. Please disregard this patch for now.

Sincerely,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-yBqBO2uoUIn7uh5g8MHY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCkGx3v+Q4flTiePgRAsBUAJ9DG5QoWOD18KRBN2lr/Qy1AbZJjgCfSS9e
Na1amgIobTr4/ituKQbnMSQ=
=TsaK
-----END PGP SIGNATURE-----

--=-yBqBO2uoUIn7uh5g8MHY--

