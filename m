Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTL3GOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTL3GOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:14:55 -0500
Received: from [38.119.218.103] ([38.119.218.103]:20411 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S264414AbTL3GOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:14:52 -0500
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.046061 secs)
Date: Tue, 30 Dec 2003 00:14:49 -0600
From: Nathan Poznick <kraken@drunkmonkey.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha (2.6.0-test11)
Message-ID: <20031230061449.GA5204@wang-fu.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
References: <20031213003841.GA5213@wang-fu.org> <20031217121010.GA11062@twiddle.net> <20031217193124.GA4837@wang-fu.org> <20031218010203.GA13385@twiddle.net> <20031230145736.4ce0ff59.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20031230145736.4ce0ff59.rusty@rustcorp.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Rusty Russell:
> This patch works for me: Nathan, does it solve your problem?
> Rusty.

This did indeed solve my problem on Alpha.  I can now use modules with
CONFIG_DEBUG_INFO.

Thanks!

--=20
Nathan Poznick <kraken@drunkmonkey.org>

"Time for go to bed." -Tor Johnson. #320


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8RfZYOn9JTETs+URAv6tAJoCXh8Yv7A5bk4xdAZL7AZ3J+UH2QCgitsn
VxsaGjZp2hgWJ6G2dBbnEXM=
=wHbB
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
