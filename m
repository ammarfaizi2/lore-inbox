Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUIFP77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUIFP77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUIFP7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:59:51 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:51860 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S268193AbUIFP6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:58:54 -0400
Subject: Re: [Transmeta hardware] Update of the CMS under Linux ?
From: Emmanuel Fleury <fleury@cs.aau.dk>
To: mocm@mocm.de
Cc: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <16700.9401.569488.38007@mocm.de>
References: <1093165082.11189.20.camel@aphrodite.olympus.net>
	 <ch8lop$m3t$1@sea.gmane.org> <1094457952.22441.34.camel@rade7.e.cs.auc.dk>
	 <16700.9401.569488.38007@mocm.de>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1094486295.4125.16.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 17:58:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 10:50, Marcus Metzler wrote:
> 
> I read the description of your bug and discovered that my problems
> with my Fujitsu Biblo Loox T93C notebook (AFAIK the Japanese version
> of the Lifebook 2120) seem to have the same cause. Since you seem to
> be collecting a list of hardware that has this bug, here is my
> information:
> I am using debian testing with kernel 2.6.4 (from kernel.org) and
> XFree86 Version 4.3.0.1. dmesg gives the following information about
> the CMS version: 
> 
> CPU:     After generic identify, caps: 0084893f 0081813f 00000000 00000000
> CPU:     After vendor identify, caps: 0084893f 0081813f 000000ce 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
> CPU: L2 Cache: 512K (128 bytes/line)
> CPU: Processor revision 1.4.1.0, 933 MHz
> CPU: Code Morphing Software revision 4.3.3-9-562
> CPU: 20030107 01:17 official release 28.0.1-4.3.3#1
> CPU serial number disabled.
> CPU:     After all inits, caps: 0080893f 0081813f 000000ce 00000000
> CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03

Thanks for your input !

I just added it to my list (I keep a more detailled description of each
plateform in my archives).

It's the first 4.3.3 that is reported to have the bug. :)

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.aau.dk

