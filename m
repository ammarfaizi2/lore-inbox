Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVJAEPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVJAEPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 00:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVJAEPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 00:15:54 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:63980 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750725AbVJAEPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 00:15:54 -0400
Date: Sat, 1 Oct 2005 14:15:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Strange commit?
Message-Id: <20051001141548.6f26f4e5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__1_Oct_2005_14_15_48_+1000_gTfWsrvQpQSpPTfr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__1_Oct_2005_14_15_48_+1000_gTfWsrvQpQSpPTfr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The first commit after v2.6.14-rc3 in your git tree seem to refer to the sa=
me tree object
ast the v2.6.14-rc3 commit does.  Is this expected?

i.e. commits 1c9426e8a59461688bb451e006456987b198e4c0 and
69d37960b578be0a69383bd71d06c1fcfb86e8b9 both refer to tree
1041e0ea3650a74d5b1fc730cd7b697d0eed5d01.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__1_Oct_2005_14_15_48_+1000_gTfWsrvQpQSpPTfr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPg15FdBgD/zoJvwRAgWYAJ9uNb7W43i7cTL5y9WwLMChqErOWACbBIho
AVAS2f6Xwl6f24mSd0FxsU4=
=ERco
-----END PGP SIGNATURE-----

--Signature=_Sat__1_Oct_2005_14_15_48_+1000_gTfWsrvQpQSpPTfr--
