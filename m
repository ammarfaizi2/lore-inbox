Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030628AbWKOQIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbWKOQIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWKOQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:08:38 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:61603 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030628AbWKOQIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:08:37 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [Opps] Invalid opcode
Date: Wed, 15 Nov 2006 18:08:49 +0200
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611120439.56199.caglar@pardus.org.tr> <4557F287.7050807@vmware.com>
In-Reply-To: <4557F287.7050807@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1399175.9BTJFQFxie";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611151808.49237.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1399175.9BTJFQFxie
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

13 Kas 2006 Pts 06:20 tarihinde, Zachary Amsden =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> I would like to find the exact cause of the problem; I suspect, as does
> Andi, that it could just be dormant. You had problems still with
> 2.6.18.latest, correct? If I can find the cause, I would like to get a
> fix into 2.6.18-stable if possible. I think you already sent me the
> reproducing kernel config, but I seem to have misplaced it. Could you
> resend? I should have some time to look at this early this week.

Sorry for late reply, [1] is the kernel config i used and if you want i can=
=20
provide ~5mb iso contains that kernel and its 26.19-rc5 version to test?

[1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/config.2.6.18
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1399175.9BTJFQFxie
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFWzuRy7E6i0LKo6YRAmloAKDSsxaB0G5HNGC/gN6l2uBuZtiYjQCgqT1E
vtFkxRfK/R+rurZ1uWn0UKM=
=m8J7
-----END PGP SIGNATURE-----

--nextPart1399175.9BTJFQFxie--
