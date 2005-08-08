Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVHHII4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVHHII4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHHII4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:08:56 -0400
Received: from smtp3.pp.htv.fi ([213.243.153.36]:10732 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750728AbVHHIIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:08:55 -0400
Date: Mon, 8 Aug 2005 11:08:51 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, rc@rc0.org.uk,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/sh64/Kconfig: doesn't need it's own LOG_BUF_SHIFT
Message-ID: <20050808080851.GD22245@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	rc@rc0.org.uk, linuxsh-shmedia-dev@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050807215803.GA4006@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20050807215803.GA4006@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2005 at 11:58:03PM +0200, Adrian Bunk wrote:
> The LOG_BUF_SHIFT from lib/Kconfig.debug is sufficient.
>=20
Yes, looks good, thanks.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC9xMT1K+teJFxZ9wRAk6GAJ9WbvenSmzQoi0Qa9dUsvIGbMUhqACfWMtX
0YabcnBXLB0dtr+Lvmf5v/A=
=NAUe
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
