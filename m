Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271359AbTGQJfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTGQJfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:35:05 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:41088 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S271359AbTGQJey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:34:54 -0400
Date: Thu, 17 Jul 2003 11:49:46 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: problems with modules
Message-Id: <20030717114946.32ac462a.martin.zwickel@technotrend.de>
In-Reply-To: <20030716083326.0c92c4f6.rddunlap@osdl.org>
References: <20030715113610.371df42b.martin.zwickel@technotrend.de>
	<20030716083326.0c92c4f6.rddunlap@osdl.org>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws93 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.6_esrN+m:_0Q49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.6_esrN+m:_0Q49
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Thanks for the hints!
Got it working now. (well, not the way i supposed to do, but it works... :)

Regards,
Martin

ps.: the kbuild system is strange

-- 
MyExcuse:
waste water tank overflowed onto computer

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.6_esrN+m:_0Q49
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FnE6mjLYGS7fcG0RAppfAJ9nx2i8dHxPQbiNbmhnOBj5D6SMbwCfRJ+Q
nvSnEoQ1zFRCZbi3LS588W4=
=tVv4
-----END PGP SIGNATURE-----

--=.6_esrN+m:_0Q49--
