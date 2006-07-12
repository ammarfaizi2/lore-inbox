Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWGLTel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWGLTel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWGLTel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:34:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750907AbWGLTek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:34:40 -0400
Message-ID: <44B54EA4.5060506@redhat.com>
Date: Wed, 12 Jul 2006 12:33:56 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
In-Reply-To: <20060712184412.2BD57180061@magilla.sf.frob.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig163ECAC3771077FDE240AA4A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig163ECAC3771077FDE240AA4A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Roland McGrath wrote:
> We could also put the uname info (modulo nodename) into the vDSO.

Or even better: real topology information.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig163ECAC3771077FDE240AA4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEtU6k2ijCOnn/RHQRAogmAJ0eEvDmqLaGqUs+ch+23VAUI2Cv3wCfalYn
6M4dZyN+adl59ma7XGVmy7w=
=nKxo
-----END PGP SIGNATURE-----

--------------enig163ECAC3771077FDE240AA4A--
