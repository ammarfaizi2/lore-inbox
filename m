Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUIGUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUIGUYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUIGUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:23:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268588AbUIGUGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:06:44 -0400
Subject: Re: The Serial Layer
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094582980.9750.12.camel@localhost.localdomain>
References: <1094582980.9750.12.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UPW7Nri5gFMOrE+t3b5M"
Organization: Red Hat UK
Message-Id: <1094587598.2801.24.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 22:06:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UPW7Nri5gFMOrE+t3b5M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-07 at 20:49, Alan Cox wrote:
> Is anyone currently looking at fixing this before I start applying
> extreme violence ? In particular to start trying to do something about
> the races in TIOCSTI, line discipline setting, hangup v receive, drivers
> abusing the API and calling ldisc.receive_buf direct ?

don't you mean the TTY layer instead of the serial layer ?

--=-UPW7Nri5gFMOrE+t3b5M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPhTOxULwo51rQBIRAkKRAJ430MSjap0khoFPvIKbTMU0tCVgMACgpKjF
oD+q4X3r3fOnViK8rNmW+x8=
=I6rH
-----END PGP SIGNATURE-----

--=-UPW7Nri5gFMOrE+t3b5M--

