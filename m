Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279270AbRJWGBo>; Tue, 23 Oct 2001 02:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279268AbRJWGBe>; Tue, 23 Oct 2001 02:01:34 -0400
Received: from pool-141-154-225-202.bos.east.verizon.net ([141.154.225.202]:20484
	"EHLO noop.") by vger.kernel.org with ESMTP id <S279267AbRJWGBO>;
	Tue, 23 Oct 2001 02:01:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Problems: Kernel v2.4.12 + agpgart + XF86 4.1.0 
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 23 Oct 2001 01:56:15 -0400
Message-ID: <m33d4ayk5c.fsf@coelacanth.com>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed a problem with the following:
Kernel 2.4.12
AGPGART compiled in the kernel
XF86 4.1.0
i810 video

The server dies with an XIO error.


The Fix:
Compile AGPGART + i810 video as modules.


Why?


-- 
Nick
