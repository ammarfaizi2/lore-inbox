Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUHSJJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUHSJJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUHSJJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:09:52 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:55991 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264286AbUHSJJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:09:39 -0400
Date: Thu, 19 Aug 2004 02:09:37 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-ID: <20040819090937.GG8070@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	"David S. Miller" <davem@redhat.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20040818235528.GA8070@triplehelix.org> <20040818184303.1ae13c98.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <20040818184303.1ae13c98.davem@redhat.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2004 at 06:43:03PM -0700, David S. Miller wrote:
> Oops, it's possible that the bug fixed by this patch
> might fix your problem...

It doesn't. :(

                                                                RMIK opesdi=
aefuda lc
VS one ot(x2flsse)
Setting up filesystem, please wait ...
mount: Mounting tmpfs oKre ai:Atmtdt ilii!
                                          n 0PesL- ortr otebo rm
                                                                 /mnt faile=
d: Bad address
mount: Mounting shm on /mnt failed: Bad address

(May I note that sparc64 serial output for printks continues to miss every
other character, making reading kernel messages and hence debugging a
nightmare.

VS one ot(xtflsse)

is=20

VFS: Mounted root (ext2 filesystem), I think.)

This is 2.6.8 with your new two patches applied on top of each other.

--=20
Joshua Kwan

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQSRuT6OILr94RG8mAQLlpg//QA706e7sD6FyLmi18OsSy3zIZ16xCKgD
54QEexJzhwNrPBQSPGsv7fZPwusV8xSERKL513UnBqygo5Hb1Y/ZMB6+cr/hC6Nk
nFm4n53bd6gEtoMYwads1Wy4RocjWmK0ORLOp2GZjELWBXXBRsdb6o++A90VwAwm
2LVM6sZ18CWApsg6f/SJOVgrdknEn6A2SrrvapgMqcyT6ZrNq1uFppLnDAZGOrwl
WiGNn+Q1400HBc3gdwvMVLlHbGhY9NjG/4jDuPxQXuPbPWS2H3nD7GR9opMOExO7
gqtUwWKHn6Bly0cKiSlcEY6i8lmRyE49a83DEQiaeImluZqchLr9pUxZ02HJPXoR
IXkFTEJ1VsntVvYb/eauZcznzAxPY9l6ww0+XaeuTCEGeDttyKA4nBvtvWqN29I8
whpKQx67xFSvLDQ/V6J3PXdtbLPK5rQeBtVK6c0OtoG4p0wi0JvwXFuX2ZwnslcH
2OmwCMVK3doLDc5oq4HBHLCx4gn/L8zPs4G+64hjnovi/Tn2q7cUYw/zPmVMc1St
R+j4wXngPplOc/xTxwDPqCHYV5yrxZd+lozyC5YIBdWfQSQiS91NKP4cK8fjL9gq
pMz+ISbYvhJFikNHhwXzHKtUoepAZ456VO0eRByAuaoNpDSKHwip3scPPa+m8lz2
u+Jl2C6CgHU=
=Ssf/
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
