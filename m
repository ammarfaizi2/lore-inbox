Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUC0DIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 22:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUC0DIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 22:08:23 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:28853 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261648AbUC0DIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 22:08:21 -0500
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was
	Re: Your opinion on the merge?]]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Frank <mhf@linuxmail.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040326222234.GE9491@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz>
	 <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz>
	 <200403250857.08920.matthias.wieser@hiasl.net>
	 <1080247142.6679.3.camel@calvin.wpcb.org.au>
	 <20040325222745.GE2179@elf.ucw.cz> <opr5gf93ik4evsfm@smtp.pacific.net.th>
	 <20040326102206.GD388@elf.ucw.cz>
	 <1080333011.2022.9.camel@laptop-linux.wpcb.org.au>
	 <20040326222234.GE9491@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080353285.9264.3.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Sat, 27 Mar 2004 14:08:05 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy again.

On Sat, 2004-03-27 at 10:22, Pavel Machek wrote:
> You are right, that would be ugly. How is encryption supposed to work,
> kernel asks you to type in a key?

I haven't thought about the specifics there. Perhaps the plugin prompts
for one, or perhaps it takes a lilo parameter? Since the resume time
command line gets forgotten with the switch back to the original kernel,
I don't think that would introduce any insecurity. Anyway, not being a
security expert, I'll leave that issue to whoever cares enough to make
an encryption plugin.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

