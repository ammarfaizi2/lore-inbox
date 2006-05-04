Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWEDKQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWEDKQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 06:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWEDKQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 06:16:22 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:10988 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751481AbWEDKQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 06:16:22 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: Any reasons not to use gcc-4.1.0 ?
Date: Thu, 4 May 2006 13:13:00 +0300
User-Agent: KMail/1.9.1
References: <355803204.20060504121040@dns.toxicfilms.tv>
In-Reply-To: <355803204.20060504121040@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2883512.xJYqafYLxM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605041313.00694.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2883512.xJYqafYLxM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Per=C5=9Fembe 4 May 2006 13:10 tarihinde, Maciej Soltysiak =C5=9Funlar=C4=
=B1 yazm=C4=B1=C5=9Ft=C4=B1:=20
> Hi,
>
> My debian testing has gcc-4.0.3 and gcc-4.1.0 available.
> I am using gcc-4.0.3 to compile the kernel but I was wondering if
> there is a reason not to use gcc-4.1.0 ?
>
> The computer is stable, no problems with compiling the kernel
> with gcc-4.0.3.
>
> Does anyone has good or bad experience and thus advice on it?

Well gcc bugzilla says : "155 regressions in 4.0 , 128 regressions in 4.1" =
,=20
that alone is a good reason to use 4.1 imho.

Regards,
ismail
=2D-=20


--nextPart2883512.xJYqafYLxM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEWdOsGp0leluI9UwRAi1sAJ0ShKbwnS5dFixHiXNqZja0i4sOFwCfQpXx
UYCYgdfSrc6HSPyTk7/IYB8=
=OMy4
-----END PGP SIGNATURE-----

--nextPart2883512.xJYqafYLxM--
