Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUGaJzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUGaJzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267929AbUGaJzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:55:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267923AbUGaJzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:55:00 -0400
Subject: Re: drm - first steps towards 64-bit correctness..
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Eric Anholt <eta@lclark.edu>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       DRI <dri-devel@lists.sourceforge.net>
In-Reply-To: <1091266345.425.34.camel@leguin>
References: <Pine.LNX.4.58.0407310940540.6368@skynet>
	 <1091266345.425.34.camel@leguin>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tTcKrD6YhLYooCEu3I6O"
Organization: Red Hat UK
Message-Id: <1091267687.2819.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 31 Jul 2004 11:54:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tTcKrD6YhLYooCEu3I6O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-07-31 at 11:32, Eric Anholt wrote:
> As long as you don't use the linux-y
> "u32"-type types, BSD should be happy with the changes.

can you explain why u32 would be outlawed? Surely it's trivial to do a
typedef for u32 on BSD for drm ??

--=-tTcKrD6YhLYooCEu3I6O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBC2xnxULwo51rQBIRAsgpAKCdexIsGn/u9bVZJkyhkD2lyQl5jwCgjqsB
9LLKErobIAEaBzHnxriiMMY=
=+9Gg
-----END PGP SIGNATURE-----

--=-tTcKrD6YhLYooCEu3I6O--

