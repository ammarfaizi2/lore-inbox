Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWJQMG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJQMG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWJQMGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:06:55 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:14772 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750700AbWJQMGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:06:55 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Tue, 17 Oct 2006 15:05:53 +0300
User-Agent: KMail/1.9.5
Cc: Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <453404F6.5040202@vmware.com> <200610170121.51492.caglar@pardus.org.tr>
In-Reply-To: <200610170121.51492.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1543721.rHVMFaA8pG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610171505.53576.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1543721.rHVMFaA8pG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

17 Eki 2006 Sal 01:21 tarihinde, S.=C3=87a=C4=9Flar Onur =C5=9Funlar=C4=B1 =
yazm=C4=B1=C5=9Ft=C4=B1:=20
> 17 Eki 2006 Sal 01:17 tarihinde, Zachary Amsden =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:
> > My nasty quick patch might not apply - the only tree I've got is a very
> > hacked 2.6.18-rc6-mm1+local-patches thing, but the fix should be obvious
> > enough.
>
> Ok, I'll test and report back...

Both 2.6.18 and 2.6.18.1 boots without any problem (and of course without=20
noreplacement workarund) with that patch.

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1543721.rHVMFaA8pG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNMchy7E6i0LKo6YRAk2EAJ0YVCgWyjo9UJJaLS+pyZbzymz05gCfeOB+
s9RsOvWlwmJwfotekxSYmsg=
=BThq
-----END PGP SIGNATURE-----

--nextPart1543721.rHVMFaA8pG--
