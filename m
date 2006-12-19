Return-Path: <linux-kernel-owner+w=401wt.eu-S932817AbWLSMme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932817AbWLSMme (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWLSMme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:42:34 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58634 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932817AbWLSMmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:42:33 -0500
Message-Id: <200612191242.kBJCgBP8020472@laptop13.inf.utfsm.cl>
To: "D. Hazelton" <dhazelton@enter.net>
cc: davids@webmaster.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPL only modules 
In-Reply-To: Message from "D. Hazelton" <dhazelton@enter.net> 
   of "Mon, 18 Dec 2006 21:38:25 CDT." <200612182138.25332.dhazelton@enter.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 19 Dec 2006 09:42:11 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 19 Dec 2006 09:42:14 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton <dhazelton@enter.net> wrote:

[...]

> The GPL is a License that covers how the code may be used, modified and 
> distributed. This is the reason that the FSF people had to make the big 
> exception for Bison, because the parser skeleton is such an integral part of 
> Bison (Bison itself, IIRC, uses the same skeleton, modified, as part of the 
> program) that truthfully, any parser built using Bison is a derivative work 
> of code released under the GPL.

They didn't "have to make the big exception", if Linus' view is correct:
The parser is built mechanically from the skeleton and the user's input, so
it is just an aggregation. Sure, it is best to make this clear (by the
exception), even if not needed.

> That said, since there is a distribution, use and modification license on
> the Linux Kernel - the GPLv2 - there are those extra restrictions on the
> code *OUTSIDE* the copyright rules.

A license like GPL works /inside/ copyright law, by allowing you to do
things the law prohibits unless the owner of the right agrees. What the law
allows explicitly, regardless of the owner's wishes, can't be taken away.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
