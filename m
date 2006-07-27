Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWG0VlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWG0VlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWG0VlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:41:25 -0400
Received: from mail.gmx.net ([213.165.64.21]:53414 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751298AbWG0VlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:41:24 -0400
X-Authenticated: #5082238
Date: Thu, 27 Jul 2006 23:41:19 +0200
From: Carsten Otto <c-otto@gmx.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS errors
Message-ID: <20060727214119.GE28912@server.c-otto.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060724191540.GD19902@server.c-otto.de> <1153770408.5723.4.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <1153770408.5723.4.camel@localhost>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2006 at 03:46:48PM -0400, Trond Myklebust wrote:
> Have you set 'no_subtree_check' in your export options on the server? If
> not, please try doing so.

No problem so far (in the last few days), seems to work. Thanks!
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEyTL/jUF4jpCSQBQRAoWIAKDJXx6hryDRg2jPWUy+iCxSiUtJNQCg5A8+
RTX8YfG4v3KW3mku31opMuQ=
=5XcP
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
