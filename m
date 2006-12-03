Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424750AbWLCAOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424750AbWLCAOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 19:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424885AbWLCAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 19:14:36 -0500
Received: from static-ip-217-172-177-14.inaddr.intergenia.de ([217.172.177.14]:56239
	"EHLO minden014.server4you.de") by vger.kernel.org with ESMTP
	id S1424750AbWLCAOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 19:14:35 -0500
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Foundation
To: stanojr@blackhole.websupport.sk
Subject: Re: 2.6.18.2 x86_64 smp oops dst_destroy dst_rcu_free
Date: Sun, 3 Dec 2006 01:14:30 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061202214954.GA9864@blackhole.websupport.sk>
In-Reply-To: <20061202214954.GA9864@blackhole.websupport.sk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12675645.s1tpt6kSpV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612030114.32902.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12675645.s1tpt6kSpV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 02 December 2006 22:49, stanojr@blackhole.websupport.sk wrote:
[...]
> pls check it out, wtf is problem :)

try disabling SMP and restart.=20
I'm most probably sure that it works this way. if so, please tell me so :)

Thanks in advance,
Christian Parpart.

--nextPart12675645.s1tpt6kSpV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFchboPpa2GmDVhK0RAgPlAJ9v4drPBAHMxqSp49JMKy3EC5ZCxQCfTj7v
UEOKJ+jjiJP+LC960rGVrNo=
=doWD
-----END PGP SIGNATURE-----

--nextPart12675645.s1tpt6kSpV--
