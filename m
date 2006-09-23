Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWIWJmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWIWJmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 05:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWIWJmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 05:42:20 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:17124 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751423AbWIWJmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 05:42:20 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Dave Jones <davej@redhat.com>
Subject: Re: [BUG] warning at kernel/cpu.c:38/lock_cpu_hotplug()
Date: Sat, 23 Sep 2006 12:42:17 +0300
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200609230145.21997.caglar@pardus.org.tr> <20060922231342.GA8414@redhat.com>
In-Reply-To: <20060922231342.GA8414@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart386340813.UtZUEDO4qQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609231242.17900.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart386340813.UtZUEDO4qQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

23 Eyl 2006 Cts 02:13 tarihinde, Dave Jones =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> This should do the trick.
> I'll merge the same patch into cpufreq.git

Yep, it solved the problem=20

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart386340813.UtZUEDO4qQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFFQF5y7E6i0LKo6YRAv1rAKCwGxzAlZANYbnc9gcOVWECthN5QwCgx2v7
sfT2Xq1ktEY0Y4dWB1CRdCw=
=Lgtr
-----END PGP SIGNATURE-----

--nextPart386340813.UtZUEDO4qQ--
