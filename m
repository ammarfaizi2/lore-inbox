Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbTFYUdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTFYUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:33:44 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264979AbTFYUdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:33:43 -0400
Date: Wed, 25 Jun 2003 13:44:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kj <kernel-janitor-discuss@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.5.73-kj1
Message-Id: <20030625134424.611c6f96.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch is at:  http://www.osdl.org/rddunlap/kj-patches/2.5.73/patch-2.5.73-kj1

changes since patch-2.5.70-bk13-kj:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop/	je_cpqarray_fix_stack_usage.patch
	Jorn Engel and Randy Dunlap
	merged by akpm on 2003-06-10 (in 2.5.71)

keep/	je_wanrouter_fix_stack_usage.patch
	Jorn Engel and Randy Dunlap

add/	unchecked_copytouser.patch
	Daniele Belluci

add/	busmouse_retcode_memleak.patch
	Flavio B. Leitner

###

--
~Randy
+ http://developer.osdl.org/rddunlap/ + http://www.xenotime.net/linux/ +
