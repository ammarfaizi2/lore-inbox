Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUAaJQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 04:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAaJQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 04:16:04 -0500
Received: from [193.170.124.123] ([193.170.124.123]:22331 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S264275AbUAaJQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 04:16:01 -0500
Date: Sat, 31 Jan 2004 10:15:51 +0100
From: JG <jg@cms.ac>
To: Lincoln Dale <ltd@cisco.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TG3: very high CPU usage
In-Reply-To: <20040125123154.A8CA4202CAA@23.cms.ac>
References: <20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<20040119033527.GA11493@linux.comp>
	<20040119033527.GA11493@linux.comp>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
	<20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
	<20040125123154.A8CA4202CAA@23.cms.ac>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__31_Jan_2004_10_15_51_+0100_ObU_mlAvFdq4=3ZM"
Message-Id: <20040131091559.8A026202D31@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__31_Jan_2004_10_15_51_+0100_ObU_mlAvFdq4=3ZM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi, 

i'm replying to my email.

> thank you for the info! i searched their site, but i only found a reference to BACS on their faq page and that this software should be on their driver cdrom (well, it is not on my netgear cdrom).
> but i'll test my cable with a fluke networks cable tester tomorrorw or on tuesday. i'll post the results if they are relevant.

well, i did a thorough cable test with a DSP-4100 fluke networks cable tester and i had some bad values. i've been using 3 cables (24m) with adapters, all single cables were fine, so the adapters seemed to cause the problem.
but i'm now using a longer x-over cable (30m) where i also get those speed problems. it is a *bit* better, i get about 1-2MB/s in both directions, but i'm also experiencing a very high error rate over the x-over cable...(~40-50 errors per second)

do you have this BACS software and is it possible to test the NIC itself with it? maybe one of my NICs is causing this.

thx,
JG


--Signature=_Sat__31_Jan_2004_10_15_51_+0100_ObU_mlAvFdq4=3ZM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAG3JPU788cpz6t2kRAj5VAJ0brYZkCAlbZ+D7HmB9LJ6Jyzi+6ACffyJ1
H2BQPixEqiZS1P2kV/vhAzY=
=a5n1
-----END PGP SIGNATURE-----

--Signature=_Sat__31_Jan_2004_10_15_51_+0100_ObU_mlAvFdq4=3ZM--
