Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUBTRMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUBTRMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:12:24 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:39812 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261347AbUBTRMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:12:19 -0500
Date: Fri, 20 Feb 2004 18:12:12 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Tyler Trafford <ttrafford@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with alsa, intel8x0 and ut2003/ut2004 on
 2.6.3(all above 2.6.2-rc3)
Message-Id: <20040220181212.19d91042@phoebee>
In-Reply-To: <E1Atqi4-0000BM-7q@torg>
References: <1077197950.4034bc7ec9730@imp1-q.free.fr>
	<E1Atqi4-0000BM-7q@torg>
X-Mailer: Sylpheed version 0.9.9claws22 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__20_Feb_2004_18_12_12_+0100_ja2Wf4pBhic3iFFh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_Feb_2004_18_12_12_+0100_ja2Wf4pBhic3iFFh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there,

I have ut2003/2004, and in both I can hear the crackling with kernel 2.6.3.
With 2.6.2-rc3 everything was fine.

I tried another openal lib (selfcompiled, armyops) but it doesn't help.
(I normally start my ut with "nice -n -1". If I start it with normal priority,
the sound gets a bit less crackling)
xmms works fine.

I have an intel8x0 alsa driver with oss support for my SiS chip
(P4 2.4Ghz/SiS645DX). And I'm using the nvidia driver for my GF card.
Kernel compiled with PREEMPT.

Regards,
Martin

-- 
MyExcuse:
The vulcan-death-grip ping has been applied.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Fri__20_Feb_2004_18_12_12_+0100_ja2Wf4pBhic3iFFh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFANj/umjLYGS7fcG0RAvtnAKCe7PSKCn94/LqITRnQP848Ya5/1ACgmQJh
t37RRuIfWMV7dAgDEykBV1I=
=Rdh+
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Feb_2004_18_12_12_+0100_ja2Wf4pBhic3iFFh--
