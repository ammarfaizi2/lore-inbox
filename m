Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVC2QfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVC2QfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVC2QfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:35:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57555 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261201AbVC2Qel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:34:41 -0500
Message-Id: <200503291631.j2TGVgUH023709@laptop11.inf.utfsm.cl>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Steven Rostedt <rostedt@goodmis.org>, floam@sh.nu,
       LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       Paul Jackson <pj@engr.sgi.com>, gilbertd@treblig.org,
       vonbrand@inf.utfsm.cl, bunk@stusta.de
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!. 
In-Reply-To: Message from Kyle Moffett <mrmacman_g4@mac.com> 
   of "Mon, 28 Mar 2005 19:56:09 EST." <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 29 Mar 2005 12:31:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 29 Mar 2005 12:31:58 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> said:

[...]

> I think it really depends on the APIs implemented.  Anything based
> on the sysfs code, even if only using the APIs, will probably be
> found to be a derivative work (NOTE: IANAL) because the sysfs API
> is so very different from everything else.  Other interfaces like
> PCI management, memory management, etc, may not be so protectable,
> because they are standard across many systems.  If Linux got a
> new and unique memory hotplug API, however, that might be a very
> different story.  Similar things could be said about integration
> between drivers and the new Unified Driver Model, which appears to
> be quite original.

Sorry, but an /interfase/ is there to do exactly that. It can be placed
under copyright protection as code, but /using/ it just can't be considered
a derived work. It makes no sense that if I get a description (docu,
example code, whatever) and learn from that how it is used, and then go and
write my own, that my code it should be a derived work of what is at the
other side of the interfase. 

If this was true, Linux would be a ripoff from Unix (same system calls),
and any program ever written for Unix would belong to Novell (or SCOXE, or
UCB, depending on whom you believe in the current mess). Note that this is
quite similar to the gargabe SCOXE tried claiming against Linux/IBM, and
had to take back.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
