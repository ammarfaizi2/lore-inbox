Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129470AbQKIPhv>; Thu, 9 Nov 2000 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbQKIPhl>; Thu, 9 Nov 2000 10:37:41 -0500
Received: from adsl-64-216-17-125.dsl.snantx.swbell.net ([64.216.17.125]:57077
	"EHLO exploits.org") by vger.kernel.org with ESMTP
	id <S129470AbQKIPhb>; Thu, 9 Nov 2000 10:37:31 -0500
Date: Thu, 9 Nov 2000 09:36:55 -0600
From: Russell Kroll <rkroll@exploits.org>
Message-Id: <200011091536.eA9Fati07393@exploits.org>
To: dake@staszic.waw.pl
Subject: Re: [PATCH] media/radio [check_region() removal... ]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ radio cards ]

> These drivers seem to be unmantained :)

Erm, no.  I'm still behind the radio-aztech driver plus my mods on
radio-aimslab and radio-cadet.  Calling them unmaintained is going too
far.  As for the others, that's up to their respective authors.

I use the cadet every couple of days on my 2.4 box so any brokenness will
stand out right away.  If the aztech and aimslab drivers have failed
recently, then it's possible that it has escaped detection.  Otherwise I
generally leave the code alone since it's been pretty stable.

Please keep me in the loop on these things.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
