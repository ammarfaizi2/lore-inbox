Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbTGJHDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbTGJHDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:03:04 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:5600
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S269019AbTGJHBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:01:07 -0400
Date: Thu, 10 Jul 2003 00:15:46 -0700
To: davidm@hpl.hp.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: .incbin patch
Message-ID: <20030710071546.GA678@triplehelix.org>
References: <200307092206.h69M6UFX003197@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <200307092206.h69M6UFX003197@napali.hpl.hp.com>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2003 at 03:06:30PM -0700, David Mosberger wrote:
> +	echo "	.section .init.ramfs,\"a\"" &gt; $(src)/initramfs_data.S
> +	echo ".incbin \"usr/initramfs_data.cpio.gz\"" &gt;&gt; $(src)/initramfs=
_data.S

Maybe you should resend it with the correct '>' signs :)

-Josh
--=20
"Notice that, written there, rather legibly, in the Baroque style common=20
to New York subway wall writers, was, uhm... was the old familiar=20
suggestion. And rather beautifully illustrated, as well..."

       -- Art Garfunkel on the inspiration for "A Poem On The Underground W=
all"

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/DRKhT2bz5yevw+4RAl1PAKDCuhHuv0x6hVGdyerN2pDvzzEsOwCfdhBF
ZHYDQQCS9V73QcjQJqDv51M=
=91tV
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
