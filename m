Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUI2NCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUI2NCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUI2NCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2763 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268368AbUI2M7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:59:35 -0400
Subject: Re: [PATCH] to allow sys_pread64 and sys_pwrite64 to be used from
	modules
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040929125835.GA6764@lkcl.net>
References: <20040929125835.GA6764@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FY1Ue8f63LJqHqtH8Oma"
Organization: Red Hat UK
Message-Id: <1096462770.2786.35.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 14:59:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FY1Ue8f63LJqHqtH8Oma
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-29 at 14:58, Luke Kenneth Casson Leighton wrote:
> i do not know if this does any damage (and i'm going to find out!)
>=20
> i seek to use these two functions from an experimental kernel module: i
> get warnings about "symbol not found" without this patch:
>=20

what on earth are you doing in your module??????


--=-FY1Ue8f63LJqHqtH8Oma
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWrGyxULwo51rQBIRAniuAJ9qS33PnZPQlFV2QyLNJWMvXde9JACglFsU
+Mu7mum0ejRodf4LZxInTNw=
=uMYr
-----END PGP SIGNATURE-----

--=-FY1Ue8f63LJqHqtH8Oma--

