Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271365AbTGQIeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271367AbTGQIeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:34:16 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:34030 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S271365AbTGQIeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:34:13 -0400
Subject: Re: [PATCH] pdcraid and weird IDE geometry
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F160965.7060403@comcast.net>
References: <3F160965.7060403@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vhYAHY7GALa8FLg1RN9t"
Organization: Red Hat, Inc.
Message-Id: <1058431742.5775.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 17 Jul 2003 10:49:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vhYAHY7GALa8FLg1RN9t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-17 at 04:26, Walt H wrote:
> compatible with the binary FastTrak.o module. I'm not much of a coder,
> so if this could be done more efficiently than my attached patch, please
> let me know. Please CC any replies. Thanks,

(un)fortionatly it's not valid to use floating point in the kernel.
Could you try the same thing by using u64 as type instead please ?

--=-vhYAHY7GALa8FLg1RN9t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FmL+xULwo51rQBIRAiPOAJ9B/WUcWl/E1i0t2KPlmZaWoyf0ogCfeGy4
RBDP2EvJDJ14bVJuTa4uljQ=
=6hOo
-----END PGP SIGNATURE-----

--=-vhYAHY7GALa8FLg1RN9t--
