Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUH2Lkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUH2Lkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUH2Lka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:40:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44945 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267739AbUH2LkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:40:16 -0400
Subject: Re: [bk pull] DRM tree - stop i830/i915 in kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408291220330.11976@skynet>
References: <Pine.LNX.4.58.0408291220330.11976@skynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zp98zYAHpbZqV8zMg7L2"
Organization: Red Hat UK
Message-Id: <1093779603.2792.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 13:40:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zp98zYAHpbZqV8zMg7L2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-29 at 13:22, Dave Airlie wrote:
> Please do a
>=20
> 	bk pull bk://drm.bkbits.net/drm-2.6
>=20
> This will include the latest DRM changes and will update the following fi=
les:

please don't do this.
This makes it not possible for distributions to ship kernels that need
to work on both old and new X versions....


--=-zp98zYAHpbZqV8zMg7L2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBMcCTxULwo51rQBIRAqV1AJ4w2HS/03RFXnsylypf5n7ES9WbLwCgjwR0
PUqVaIJxrC9uVbCX5QDenoM=
=Nxp5
-----END PGP SIGNATURE-----

--=-zp98zYAHpbZqV8zMg7L2--

