Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTIZK23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 06:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTIZK23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 06:28:29 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:42385 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261368AbTIZK20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 06:28:26 -0400
Date: Fri, 26 Sep 2003 12:28:22 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: mru@users.sourceforge.net (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmware in Linux 2.6
Message-Id: <20030926122822.27a7332d.martin.zwickel@technotrend.de>
In-Reply-To: <yw1xwubvq3vq.fsf@users.sourceforge.net>
References: <yw1xwubvq3vq.fsf@users.sourceforge.net>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.4claws17 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.0-test4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__26_Sep_2003_12_28_22_+0200_sXN+t2NA2wYkX./6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__26_Sep_2003_12_28_22_+0200_sXN+t2NA2wYkX./6
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2003 11:46:01 +0200
mru@users.sourceforge.net (M=E5ns Rullg=E5rd) bubbled:

>=20
> Is it possible to use vmware with Linux 2.6?  The kernel modules
> (obviously) fail to compile.
>=20

Yes, it is.
I use vmware 4.0.2.5592 with 2.6.0-t3.
You just need the vmware-any-any-update40.tar.gz.
Get it here: http://ftp.cvut.cz/vmware/vmware-any-any-update40.tar.gz
unpack and copy it to vmware-src/lib/modules/source/

hope this helps!

Regards,
Martin

ps.: i use gentoo, and i just looked at the package build scripts.

--=20
MyExcuse:
Terrorists crashed an airplane into the server room, have to remove /bin/la=
den.
(rm -rf /bin/laden)

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Fri__26_Sep_2003_12_28_22_+0200_sXN+t2NA2wYkX./6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/dBTGmjLYGS7fcG0RAh0LAKCxnhQO10p2BNfpaq6iFgF7kUwV7gCfayJM
84gLkEM1juEeoMxGwdRaG7w=
=acio
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Sep_2003_12_28_22_+0200_sXN+t2NA2wYkX./6--
