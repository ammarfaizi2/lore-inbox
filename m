Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTEMPte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTEMPte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:49:34 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:43898 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261704AbTEMPt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:49:28 -0400
Subject: Re: kernel BUG at inode.c:562!
From: Anders Karlsson <anders@trudheim.com>
To: Oleg Drokin <green@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513124135.GA28238@namesys.com>
References: <1052823517.5022.3.camel@tor.trudheim.com>
	 <20030513124135.GA28238@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p7ZFOgWxlcnpL/gXMCJD"
Organization: Trudheim Technology Limited
Message-Id: <1052841728.5349.40.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 13 May 2003 17:02:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p7ZFOgWxlcnpL/gXMCJD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-13 at 13:41, Oleg Drokin wrote:
> Hello!

[snip]

> Hm, can you please try to reproduce without vmware modules ever being loa=
ded?

I have stopped VMware and prevented it from starting again. I have
without problem built 30+ rpms and subsequently cleaned up the BUILD
directory. Not a single problem. I will however carry on testing.

I will also notify VMware about a potential problem with their product.
They have been helpful before.

Regards,

/Anders


--=-p7ZFOgWxlcnpL/gXMCJD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+wRcALYywqksgYBoRAmoJAKDGrxJsj+59xKkFqV7RmeIyQ3vnMACgiBxv
V/ODBzG+qDl/esm4HuzNkJI=
=oaZj
-----END PGP SIGNATURE-----

--=-p7ZFOgWxlcnpL/gXMCJD--

