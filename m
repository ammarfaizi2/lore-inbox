Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJIMXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTJIMXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:23:40 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:39921 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262110AbTJIMXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:23:39 -0400
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Gabor MICSKO <gmicsko@szintezis.hu>
In-Reply-To: <3F854C13.3010902@freemail.hu>
References: <3F77F752.7020404@externet.hu>
	 <Pine.LNX.4.56.0309301655330.9692@localhost.localdomain>
	 <3F854C13.3010902@freemail.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RezebPcoKNPbIjmGFqIw"
Organization: Red Hat, Inc.
Message-Id: <1065702208.5268.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Thu, 09 Oct 2003 14:23:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RezebPcoKNPbIjmGFqIw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-10-09 at 13:52, Boszormenyi Zoltan wrote:

> Shared library randomisation test        : No randomisation  *** this cha=
nged ***

this is because you're running prelink to fix all libs into place...


--=-RezebPcoKNPbIjmGFqIw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/hVNAxULwo51rQBIRAseVAKCZynjeoB+NGiTaKhyWwWfkgK6gUQCgjCVL
AuVV1BUeYQS4j5Tjc3QZ9vw=
=hGHF
-----END PGP SIGNATURE-----

--=-RezebPcoKNPbIjmGFqIw--
