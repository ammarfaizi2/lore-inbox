Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756305AbWKRMfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbWKRMfM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 07:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756312AbWKRMfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 07:35:03 -0500
Received: from lugor.de ([212.112.242.222]:36801 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1756305AbWKRMfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 07:35:01 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: IEEE80211 and IPW3945
Date: Sat, 18 Nov 2006 13:31:40 +0100
User-Agent: KMail/1.9.5
Cc: jketreno@linux.intel.com, linux-kernel@vger.kernel.org
References: <20061118102056.GA4492@gimli>
In-Reply-To: <20061118102056.GA4492@gimli>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1468166.5ol7sJaUzv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611181331.44937.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Sat, 18 Nov 2006 13:31:45 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1468166.5ol7sJaUzv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 18 November 2006 11:20, Martin Lorenz wrote:
> Dear James,
>
> I just had some issues when trying to compile ieee80211 1.2.15 together
> with ipw3945 1.1.2 on the latest kernel tree
>
> attached are two patches I had to create to work around it
> I guess they are self-explanatory :-)

I think you should not recreate linux/config.h but remove the reference to=
=20
it...
=2D-=20
Regards,
Christian

--nextPart1468166.5ol7sJaUzv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFXv0wlZfG2c8gdSURAnrzAJ4sESveZ70t1KQS9zOxBn8OBrI8+ACg7hEw
V7s96kfZmCgltnbzqFgG0BM=
=9Qbb
-----END PGP SIGNATURE-----

--nextPart1468166.5ol7sJaUzv--
