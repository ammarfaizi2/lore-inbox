Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTKCKvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKCKvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:51:37 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:59013 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261974AbTKCKvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:51:36 -0500
Date: Mon, 3 Nov 2003 11:51:34 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: kernel floating point emulation for big endian arm?
Message-Id: <20031103115134.63262f54.martin.zwickel@technotrend.de>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.6claws65 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.0-test4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_11_51_34_+0100_4klxMt1dLE0BTVgj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_11_51_34_+0100_4klxMt1dLE0BTVgj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there!

Is there a working version of kernel floating point emulation for big endian
arm?

The version I currently use is 2.4.21-pre5 and fp emu doesn't work
correctly I think.

Regards,
Martin

-- 
MyExcuse:
The MGs ran out of gas.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Mon__3_Nov_2003_11_51_34_+0100_4klxMt1dLE0BTVgj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pjM2mjLYGS7fcG0RAmqtAJ9lLfajtotaknWxARqYkAjTaXgIsgCfcSoX
9dGu24EudAbpgnva03yq5uM=
=5nuf
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_11_51_34_+0100_4klxMt1dLE0BTVgj--
