Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754570AbWKHMcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbWKHMcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbWKHMcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:32:53 -0500
Received: from lugor.de ([212.112.242.222]:43954 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1754572AbWKHMcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:32:52 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.19-rc5-mm1
Date: Wed, 8 Nov 2006 13:32:28 +0100
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611081307.27365.m.kozlowski@tuxland.pl>
In-Reply-To: <200611081307.27365.m.kozlowski@tuxland.pl>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1892919.sYjX6026dM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611081332.36644.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Wed, 08 Nov 2006 13:32:33 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1892919.sYjX6026dM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 08 November 2006 13:07, Mariusz Kozlowski wrote:
> Hello,
>
> 	This was seen on athlon machine with 'make allmodconfig'.

You need binutils >=3D 2.16.91.0.2 if CONFIG_KVM is enabled. See "[PATCH 0/=
14]=20
KVM: Kernel-based Virtual Machine (v4)" for details and discussion.
=2D-=20
Regards,
Christian

--nextPart1892919.sYjX6026dM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUc5klZfG2c8gdSURAv9CAJ9U3opd7+bcNKuK6q/vnEkAq/4GxQCeP1hO
RbctAeelMWM2bLqrcVLgxus=
=+GRb
-----END PGP SIGNATURE-----

--nextPart1892919.sYjX6026dM--
