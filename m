Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbQKOKKH>; Wed, 15 Nov 2000 05:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbQKOKJ5>; Wed, 15 Nov 2000 05:09:57 -0500
Received: from deckard.concept-micro.com ([62.161.229.193]:1104 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S129958AbQKOKJv>; Wed, 15 Nov 2000 05:09:51 -0500
Message-ID: <XFMail.20001115103837.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.GSU.4.21.0011141847460.26147-100000@lennon.cc.gatech.edu>
Date: Wed, 15 Nov 2000 10:38:37 +0100 (CET)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: Zhiruo Cao <zhiruo@cc.gatech.edu>
Subject: RE: Question on bdflush
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 14-Nov-2000, Zhiruo Cao écrivait :
> Why does bdflush (kupdated and kflushed) writes to disk periodically even
> though the system is apparently idle.  I think if no more new buffers
> becomes dirty, kflushed show not write anything to disk.   I'm working
> on a notebook, and I found the periodic disk access is very annoying and
> consuming a lot of power.

Look for noflushd on Freshmeat...


-- 
Linux blade.workgroup 2.4.0-test11 #1 Tue Nov 14 16:44:49 CET 2000 i686 unknown
 10:38am  up 17:34,  2 users,  load average: 1.13, 1.17, 1.17

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
