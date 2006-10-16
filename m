Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWJPWXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWJPWXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJPWXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:23:01 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:9386 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1422657AbWJPWW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:22:57 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Tue, 17 Oct 2006 01:21:51 +0300
User-Agent: KMail/1.9.5
Cc: Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <200610121045.32846.caglar@pardus.org.tr> <453404F6.5040202@vmware.com>
In-Reply-To: <453404F6.5040202@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3124888.ifulkLzXIf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610170121.51492.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3124888.ifulkLzXIf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

17 Eki 2006 Sal 01:17 tarihinde, Zachary Amsden =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> My nasty quick patch might not apply - the only tree I've got is a very
> hacked 2.6.18-rc6-mm1+local-patches thing, but the fix should be obvious
> enough.

Ok, I'll test and report back...

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3124888.ifulkLzXIf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNAX/y7E6i0LKo6YRAu1sAJ4pNEGtm9N7L9eCTJOW1zx97jW2DQCgtwYB
DBRxEWh2oyY/nYMFfByjGzs=
=jCwI
-----END PGP SIGNATURE-----

--nextPart3124888.ifulkLzXIf--
