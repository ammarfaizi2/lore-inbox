Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVHIFlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVHIFlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVHIFlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:41:53 -0400
Received: from lugor.de ([212.112.242.222]:36324 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S932450AbVHIFlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:41:52 -0400
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: Hang at resume with AC adapter not plugged
Date: Tue, 9 Aug 2005 07:41:21 +0200
User-Agent: KMail/1.8.2
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
Cc: suspend2-devel@lists.suspend2.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17843775.1XZYRB4ttW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508090741.29149.mail@earthworm.de>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart17843775.1XZYRB4ttW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I have a little problem with software suspend 2.1.9.1[012] on 2.6.13-rc[345=
6].=20
The system hangs on resume if the AC adapter is not plugged in. Everything=
=20
works well if I use 2.1.9.5 on 2.6.12.x or plug in the AC adapter. I've tri=
ed=20
acpi-20050729 for 2.6.13-rc6 but that did not change anything. The system i=
s=20
a Sumsung X10.

Any ideas what could be the problem?
=2D-=20
Regards,
Christian

--nextPart17843775.1XZYRB4ttW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.18 (GNU/Linux)

iD8DBQBC+EIJlZfG2c8gdSURAnUhAKDYVY8ek4+0bew/blaXR8Mn/IYTDQCZAWrv
iehHgcQa+uS5BGNRQvwhB00=
=/p4Y
-----END PGP SIGNATURE-----

--nextPart17843775.1XZYRB4ttW--
