Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272485AbTHOXSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272495AbTHOXSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:18:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:6074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272485AbTHOXSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:18:45 -0400
Date: Fri, 15 Aug 2003 16:15:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mark McClelland <mark@alpha.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: remove "Linux 2.4" strings
Message-Id: <20030815161514.24eed70a.rddunlap@osdl.org>
In-Reply-To: <3F3D65D2.1070700@alpha.dyndns.org>
References: <20030815101143.72bbea51.rddunlap@osdl.org>
	<3F3D65D2.1070700@alpha.dyndns.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 15:59:30 -0700 Mark McClelland <mark@alpha.dyndns.org> wrote:

| Randy.Dunlap wrote:
| 
| >This patch removes "Linux 2.4" printed strings from a few
| >drivers and net protocols.
| >
| >Instead of changing them to "Linux 2.6", they should just
| >be deleted, I think.  Other suggestions?
| >
| These strings are sometimes useful to maintainers when handling bug 
| reports. Vendors and users often replace drivers with out-of-tree 
| versions to gain features that aren't included in the in-kernel version 
| (because of licensing issues, etc...). I have had this happen with ov511 
| a number of times, so I add the "for Linux 2.4" now.

OK, I won't push them.
Just seems odd to see drivers "for Linux 2.4" in the 2.6 tree.

Thanks for your RFC reply.

--
~Randy
