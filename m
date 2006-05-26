Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWEZQbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWEZQbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWEZQbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:31:44 -0400
Received: from amnesiac.heapspace.net ([195.54.228.42]:14859 "EHLO
	amnesiac.heapspace.net") by vger.kernel.org with ESMTP
	id S1751102AbWEZQb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:31:27 -0400
Date: Fri, 26 May 2006 19:31:25 +0300
From: Daniel Stone <daniel@fooishbar.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel design: support for multiple local users
Message-ID: <20060526163125.GI16521@fooishbar.org>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910605260901h6452c795s1c40cf61b47fc69a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <9e4733910605260901h6452c795s1c40cf61b47fc69a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2006 at 12:01:15PM -0400, Jon Smirl wrote:
> It is possible to set the current X server up to support this
> configuration. Using the X server this way has some drawbacks. The X
> server needs to be run as root.

So far, so good.

> The multiple users are sharing a
> single X server image so things they do can impact the other users.

No, they're not.

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEdy1dRkzMgPKxYGwRAkwbAJ9zjwlKvb/t32fvOYhaMEl6t2v8MwCdFUeN
INl4vFpHBJIxKPrVs6NkXSk=
=qLNo
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
