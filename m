Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTEVTg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTEVTg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:36:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:12197 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263185AbTEVTgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:36:55 -0400
Subject: Re: 2.5.69-mm8
From: Paul Larson <plars@linuxtestproject.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <9790000.1053632393@[10.10.2.4]>
References: <20030522021652.6601ed2b.akpm@digeo.com>
	<1053629620.596.1.camel@teapot.felipe-alfaro.com>
	<1053631843.2648.3248.camel@plars>  <9790000.1053632393@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-NhwYcdGnh7oj3f2X+q0q"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 May 2003 14:49:44 -0500
Message-Id: <1053632985.598.3257.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NhwYcdGnh7oj3f2X+q0q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-22 at 14:39, Martin J. Bligh wrote:
> Also seems to hang rather easily. When it gets into that state, it's diff=
icult
> to tell what works and what doesn't ... I can login over serial, but not=20
> start new ssh's and "ps -ef" hangs for ever. I'll try to get some more
> information, and assemble a less-totally-crap bug report.
ssh and ps -ef seem to work fine on my machine

-Paul Larson

--=-NhwYcdGnh7oj3f2X+q0q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj7NKdcACgkQbkpggQiFDqd6+wCfWyjuPyAOgcJkWILgi7lmHjag
HtkAnjoPcKiBs2E9YuQwKlnp1tyLffr5
=jatF
-----END PGP SIGNATURE-----

--=-NhwYcdGnh7oj3f2X+q0q--

