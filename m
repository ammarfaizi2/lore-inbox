Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTJET4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTJET4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:56:09 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:49391 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263850AbTJET4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:56:06 -0400
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Maciej Zenczykowski <maze@cela.pl>
Cc: David Woodhouse <dwmw2@infradead.org>, Andre Hedrick <andre@linux-ide.org>,
       Rob Landley <rob@landley.net>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0310052120440.12277-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0310052120440.12277-100000@gaia.cela.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fr7SS3gziCdos6HzPOA8"
Organization: Red Hat, Inc.
Message-Id: <1065383677.5032.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sun, 05 Oct 2003 21:54:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fr7SS3gziCdos6HzPOA8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-10-05 at 21:32, Maciej Zenczykowski wrote:
>=20
> On the other hand any running program on linux dynamically links (via=20
> syscalls) against the kernel... I think everyone agrees that dynamically=20
> linking against the kernel in this manner should be allowed and not a=20
> violation of the GPL of the kernel source...

"linking" is a bit tricky here. Traditionally linking involves resolving
addresses of symbols from the other part; system calls don't have any of
this, they are hard coded, documented and fixed numbers... numbers that
also work on BSD and AIX (in the linux personality).


--=-Fr7SS3gziCdos6HzPOA8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/gHb9xULwo51rQBIRAlrLAJ9/tIzK4KtY5ptY/X6aCgAfxyc5JQCffrro
CWPxTrK0tu02jxnSMdFhUGI=
=QwOY
-----END PGP SIGNATURE-----

--=-Fr7SS3gziCdos6HzPOA8--
