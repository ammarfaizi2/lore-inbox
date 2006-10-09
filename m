Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWJIVww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWJIVww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWJIVww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:52:52 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:38868 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S964886AbWJIVww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:52:52 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Dave Jones <davej@redhat.com>
Subject: Re: Ondemand/Conservative not working with 2.6.18
Date: Tue, 10 Oct 2006 00:52:52 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200610041633.44870.caglar@pardus.org.tr>
In-Reply-To: <200610041633.44870.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2390771.W5k5RkZT5k";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610100052.52269.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2390771.W5k5RkZT5k
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

04 Eki 2006 =C3=87ar 16:33 tarihinde, S.=C3=87a=C4=9Flar Onur =C5=9Funlar=
=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:=20
> Hi;
>
> With kernel 2.6.18 "ondemand" and "conservative" governors are not working
> with Sony Vaio FS-215B laptop, no frequency scaling or anything else :)
> occurs while system is %100 idle or at any workload using these governors,
> but setting "performance" governor changes to 1733 Mhz and "powersave"
> changes to 800 Mhz as expected. They all works without a problem with
> 2.6.16.x, system information below;

Also not working with 2.6.19-rc1

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2390771.W5k5RkZT5k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKsS0y7E6i0LKo6YRAjgTAJ9J9ihRSXOTrV9W3RmqPkir81KPjwCfZYKx
ktxCvpqpaDUrLnltvfnGR1M=
=zMQM
-----END PGP SIGNATURE-----

--nextPart2390771.W5k5RkZT5k--
