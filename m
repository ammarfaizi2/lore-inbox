Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbQKJSO1>; Fri, 10 Nov 2000 13:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbQKJSOR>; Fri, 10 Nov 2000 13:14:17 -0500
Received: from z211-19-81-189.dialup.wakwak.ne.jp ([211.19.81.189]:25329 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S130741AbQKJSN4>;
	Fri, 10 Nov 2000 13:13:56 -0500
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001029141214.B615@suse.de>
In-Reply-To: <20001028201047.A5879@suse.de>
	<20001029134145N.shibata@luky.org>
	<20001029141214.B615@suse.de>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001111031748S.shibata@luky.org>
Date: Sat, 11 Nov 2000 03:17:48 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or you could try the 2.4 version, as I said originally the 2.2 patch
> hasn't been tested at all. It would be nice to know if that works
> for you, as I may have screwed up the backport a bit.

I tested on 2.4-test10 + dvd-ram-240t10p5.diff.bz2 + dvdram-ro_fix.diff env.
It occured oops too :-(.

And I forgot to say that my DVD-RAM drive is a new 9.4GB DVD-RAM model drive.

Best Regards,

Hisaaki Shibata

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
