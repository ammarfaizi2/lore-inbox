Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTD2XBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 19:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTD2XBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 19:01:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18384 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261925AbTD2XBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 19:01:15 -0400
Date: Tue, 29 Apr 2003 16:11:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to
 return -E Linux 2.5.68
Message-Id: <20030429161128.3b8c762b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003 23:08:30 +0000 Gabriel Devenyi <devenyga@mcmaster.ca> wrote:

| Thanks for the suggestions, I'm kinda new at this and just following the TODO 
| which unfortuately says "sed s/return EWHATEVER/return -EWHATEVER/". I'll 
| work on checking the things you suggested. As for your other questions, the 
| kernel did build but I didn't attempt to boot it, I'll be sure to do so in 
| the future. Thanks for the encouragement.
| 
| P.S. Anyone who works on KernelJanitor, kj.pl is suggesting some of the things 
| I'm changing which aparently I shouldn't.


The kernel-janitor TODO should be your guide.  However, it needs some
updating too, so the best thing to do is ask about things on
kernel-janitor-discuss@lists.sf.net before you spend time on them.

[item updates are welcome]

--
~Randy
