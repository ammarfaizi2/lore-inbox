Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266323AbUAHXFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUAHXFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:05:45 -0500
Received: from smtp.golden.net ([199.166.210.31]:10002 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S266323AbUAHXFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:05:44 -0500
Date: Thu, 8 Jan 2004 18:05:33 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New FBDev patch
Message-ID: <20040108230533.GA20713@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, Jan 08, 2004 at 10:03:54PM +0000, James Simmons wrote:
> This is the latest patch against 2.6.0-rc3. Give it a try.
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>=20
> Here are the changes.
>=20
>  drivers/video/pvr2fb.c                |  846 -
[snip]
> <jsimmons@maxwell.earthlink.net> (03/05/14 1.1046.73.2)
>    [PVR2 FBDEV] Port of the Dreamcast Frambuffer to the new api.
>=20
Please drop this from your patch, it re-introduces a number of parse
errors that I already fixed in the 2.6 tree.

On another note, I do have some more pvr2fb updates pending, but I'll send
these to you seperately.


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE//eI91K+teJFxZ9wRAmaBAJsF/NmKb8BqQQNiztX8XPxqNs/JWQCfcv5U
3cgWdlqdMbuAAT5IkBXyBLY=
=wXei
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
