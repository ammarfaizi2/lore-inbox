Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271794AbTGRUvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTGRUvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:51:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:8328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271794AbTGRUun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:50:43 -0400
Date: Fri, 18 Jul 2003 14:03:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: willy@meta-x.org
Subject: announce: kmsgdump update for 2.5.75
Message-Id: <20030718140309.623ff4c9.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've updated kmsgdump for Linux 2.5.75.  The patch is available at
  http://www.xenotime.net/linux/kmsgdump/2.5.75/

Unfortunately it's not working with Linux-2.6.0-test1 and I haven't
been able to determine why yet.  If someone could point out to me
what subtle x86 changes there were between 2.5.75 and 2.6.0-test1,
I'm listening, or even better, buying beers next week in Canada.
I've been thru the 2.5.75-to-2.6.0-test1 patch file a couple of
times without finding it, and still looking.

Thanks,
--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
