Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269842AbUJHLhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269842AbUJHLhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUJHLfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:35:16 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:45451 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269842AbUJHLeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:34:16 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc3-mm3
Date: Fri, 8 Oct 2004 04:34:09 -0700
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041007015139.6f5b833b.akpm@osdl.org> <20041007150708.5d60e1c3.akpm@osdl.org> <1097188883l.6408l.1l@werewolf.able.es>
In-Reply-To: <1097188883l.6408l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1121741.tb22j1FS7b";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410080434.13649.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1121741.tb22j1FS7b
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 07 October 2004 15:41, J.A. Magallon wrote:
> - 1Gb lowmem
>
> How about including the last one in -mm, for testing ? I use it in a serv=
er
> and in my home workstation and it works fine (even with nvidia drivers ;)
> ).

It violates the ELF standard, which breaks some apps (notably Valgrind). I=
=20
don't think it's appropriate for -mm. People that really need it can patch=
=20
themselves.

=2DRyan=20

--nextPart1121741.tb22j1FS7b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBZns1W4yVCW5p+qYRAmmAAJ9dYN7ITNnPgeOGZmIA/r4VPOl+GQCeJVUr
SUc8lWFQ14ZZ35Da91lk/yc=
=kgnY
-----END PGP SIGNATURE-----

--nextPart1121741.tb22j1FS7b--
