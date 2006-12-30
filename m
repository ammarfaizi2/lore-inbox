Return-Path: <linux-kernel-owner+w=401wt.eu-S1030201AbWL3BXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWL3BXA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWL3BXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:23:00 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35373 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030201AbWL3BXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:23:00 -0500
Message-Id: <200612300121.kBU1LaiQ017876@laptop13.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Ben Collins <ben.collins@ubuntu.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Holbach <daniel.holbach@ubuntu.com>
Subject: Re: 2.6.20-rc2: known unfixed regressions 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Fri, 29 Dec 2006 20:25:25 BST." <20061229192525.GU20714@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 29 Dec 2006 22:21:36 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 29 Dec 2006 22:21:41 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

[...]

> Subject    : BUG at fs/buffer.c:1235 when using gdb
> References : http://lkml.org/lkml/2006/12/17/134
> Submitter  : Andrew J. Barr <andrew.james.barr@gmail.com>
> Fixed-By   : Jeremy Fitzhardinge <jeremy@goop.org>
> Commit     : 8701ea957dd2a7c309e17c8dcde3a64b92d8aec0
> Status     : fixed in -rc2

This I see in Fedora rawhide i686 2.6.19-1.2891.fc7 (BZ'd at
<https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=220855>
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
