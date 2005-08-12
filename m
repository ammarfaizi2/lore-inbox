Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVHLDSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVHLDSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVHLDSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:18:04 -0400
Received: from smtp3.pp.htv.fi ([213.243.153.36]:24527 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751145AbVHLDSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:18:01 -0400
Date: Fri, 12 Aug 2005 06:17:56 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Robert Love <rml@novell.com>
Cc: Mr Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       The Cutch <ttb@tentacle.dhs.org>
Subject: Re: [patch] SH: inotify and ioprio syscalls
Message-ID: <20050812031756.GA306@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Robert Love <rml@novell.com>, Mr Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	The Cutch <ttb@tentacle.dhs.org>
References: <1123704797.23297.13.camel@betsy> <1123704429.23297.11.camel@betsy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <1123704797.23297.13.camel@betsy> <1123704429.23297.11.camel@betsy>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2005 at 04:07:09PM -0400, Robert Love wrote:
> Add inotify and ioprio syscall stubs to SH.
>=20
> 	Robert Love
>=20
>=20
> Signed-off-by: Robert Love <rml@novell.com>
>=20
>  arch/sh/kernel/entry.S  |    5 +++++
>  include/asm-sh/unistd.h |    8 +++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20

On Wed, Aug 10, 2005 at 04:13:17PM -0400, Robert Love wrote:
> Add inotify and ioprio syscall stubs to SH64.
>=20
> 	Robert Love
>=20
>=20
> Signed-off-by: Robert Love <rml@novell.com>
>=20
>  arch/sh64/kernel/syscalls.S |    5 +++++
>  include/asm-sh64/unistd.h   |    7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
Both look good, thanks.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC/BTk1K+teJFxZ9wRAvcSAJ0S2vttEFHPVDs+ma/WMbW7FrYCmgCfadyn
omX9/VSKY9pIdPGYvqTdSlE=
=L4kx
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
