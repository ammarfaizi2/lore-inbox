Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUGFPdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUGFPdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUGFPdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:33:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:20135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263971AbUGFPdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:33:07 -0400
Date: Tue, 6 Jul 2004 08:28:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-Id: <20040706082842.50dde08f.rddunlap@osdl.org>
In-Reply-To: <20040704110443.GI4923@krispykreme>
References: <20040704065811.GA4923@krispykreme>
	<20040704070144.GB4923@krispykreme>
	<200407041224.47578.bzolnier@elka.pw.edu.pl>
	<20040704110443.GI4923@krispykreme>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jul 2004 21:04:43 +1000 Anton Blanchard wrote:

|  
| > Can't we just remove these variables?
| 
| Certainly possible. Randy, does IKCONFIG_VERSION serve a purpose?

Just kill it.

Thanks,
--
~Randy
