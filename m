Return-Path: <linux-kernel-owner+w=401wt.eu-S965114AbXAEA1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbXAEA1B (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbXAEA1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:27:00 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39334 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965114AbXAEA07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:26:59 -0500
Message-Id: <200701050025.l050PPWt007260@laptop13.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: 2.6.20-rc3: known unfixed regressions (v3) 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Thu, 04 Jan 2007 18:46:32 BST." <20070104174632.GC20714@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Thu, 04 Jan 2007 21:25:25 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 04 Jan 2007 21:25:42 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.

[...]

> Subject    : SPARC64: Can't mount /  (CONFIG_SCSI_SCAN_ASYNC=y ?)
> References : http://lkml.org/lkml/2006/12/13/181
>              http://lkml.org/lkml/2007/01/04/75
> Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
> Status     : unknown

Fixed in 2.6.20-rc3 (perhaps was due to SCSI_SCAN_ASYNC)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
