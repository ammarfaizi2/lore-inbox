Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVAYOLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVAYOLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVAYOIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:08:43 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:1769 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261948AbVAYOHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:07:23 -0500
Date: Tue, 25 Jan 2005 16:07:21 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sh@m17n.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use generic hardirq code on SH
Message-ID: <20050125140721.GA8375@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Christoph Hellwig <hch@lst.de>, linux-sh@m17n.org,
	linux-kernel@vger.kernel.org
References: <20050122122009.GA9635@lst.de> <20050122122102.GB9635@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20050122122102.GB9635@lst.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 22, 2005 at 01:21:02PM +0100, Christoph Hellwig wrote:
> (forgot to mention that I'd like to thank Tom Rini for testing the
>  patch on his Hitachi SE7750 and correcting two stupid little bugs)
>=20
Looks good, I'll apply it, thanks.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB9lKZ1K+teJFxZ9wRAk+YAJ0Z+Ikyz/DEcaymm8O5JdYrhH2yrACfUjxz
vKcpcvBwKc+rM3m8kqmUjhc=
=Sv4E
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
