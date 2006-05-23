Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWEWQqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWEWQqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEWQqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:46:39 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:7555 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S932089AbWEWQqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:46:39 -0400
Date: Tue, 23 May 2006 18:46:34 +0200
From: markus reichelt <ml@mareichelt.de>
Subject: kernel: padlock: VIA PadLock not detected.
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20060523164634.GC9829@dantooine>
Organization: still stuck in reorganization mode
MIME-version: 1.0
Content-type: multipart/signed; boundary=X1bOJ3K7DJ5YkBrT;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.11
X-PGP-Key: 0xC2A3FEE4
X-PGP-Fingerprint: FFB8 E22F D2BC 0488 3D56  F672 2CCC 933B C2A3 FEE4
X-Request-PGP: http://mareichelt.de/keys/c2a3fee4.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I get the following message on a Nehemiah system. Any ideas about
that?

kernel 2.6.16.17 (I tried other stable versions too)

CONFIG_CRYPTO_DEV_PADLOCK=3Dy
CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dy

kernel: CPU0: Centaur VIA Nehemiah stepping 01
kernel: padlock: VIA PadLock not detected

cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah
stepping        : 1
cpu MHz         : 999.663
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge cmov mmx fxsr sse
fxsr_opt
bogomips        : 2002.28


--=20
left blank, right bald

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEczxqLMyTO8Kj/uQRAnGoAJ9gz9D4CWKT1rfHLsF3LXYlwASajQCfVWoa
Cf6JUOx0NkhLcaMescpp3GE=
=hEfC
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

