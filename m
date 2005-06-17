Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVFQBSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVFQBSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFQBSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:18:38 -0400
Received: from downeast.net ([12.149.251.230]:29397 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261877AbVFQBSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:18:35 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Thu, 16 Jun 2005 21:18:06 -0400
User-Agent: KMail/1.8
Cc: "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <Pine.LNX.4.61.0506161036370.30607@chaos.analogic.com> <20050616150419.GY23488@csclub.uwaterloo.ca>
In-Reply-To: <20050616150419.GY23488@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart36103587.OzXh0cRd2r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506162118.18470.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart36103587.OzXh0cRd2r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 16 June 2005 11:04 am, Lennart Sorensen wrote:
>  Most people seem happy with 50 or so being a good limit even though many
>  systems support much longer.=20

50 characters or 50 bytes? Because in the case of UTF-8, if you do a lot of=
=20
three byte characters (which require four bites to encode), 50 bytes is ver=
y=20
short.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart36103587.OzXh0cRd2r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsiTa8Gvouk7G1cURAo+/AJ0SkLQHEZKVDy12Ug2MuZeK+6MW1QCgrUan
Oc/Z/eA65+cAOtV8v/RzhPc=
=dVjM
-----END PGP SIGNATURE-----

--nextPart36103587.OzXh0cRd2r--
