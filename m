Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFXUzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTFXUzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:55:44 -0400
Received: from knycz.net ([80.55.181.226]:23562 "EHLO knycz.net")
	by vger.kernel.org with ESMTP id S263355AbTFXUzn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:55:43 -0400
Date: Tue, 24 Jun 2003 23:09:52 +0200
From: Przemyslaw =?ISO-8859-2?Q?Stanis=B3aw?= Knycz <zolw@wombb.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5.73] Problem with module xfs at alpha (unresolved symbol
 files_stat).
Message-Id: <20030624230952.3dfb6582.zolw@wombb.edu.pl>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pld-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

After compiling xfs on alpha i have one unresolved symbol:
/lib/modules/2.5.73-0.2/kernel/fs/xfs/xfs.ko needs unknown symbol
files_stat

At ia32 this problem is not exist.

I think that problem with xfs was earlier than 2.5.73, becouse 2.5.72
have it too (i've not tested older kernels).

Cheers

-- 
 .mailto p r z e m y s l a w at k n y c z dot n e t.
| Przemys³aw "djrzulf" Knycz, djrzulf@jabber.gda.pl |
| Net/Sys Administrator, PLD Developer, RLU: 213344 |
`- To see tomorrow's PC, look at today's Macintosh -'
