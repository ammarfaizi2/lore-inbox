Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVLFCXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVLFCXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVLFCXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:23:47 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:49303 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S964927AbVLFCXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:23:46 -0500
Message-Id: <200512060054.jB60svAU003892@pincoya.inf.utfsm.cl>
To: mhf@users.berlios.de
cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Michael Frank <mhf@users.berlios.de> 
   of "Mon, 05 Dec 2005 10:47:24 BST." <20051205142941.DBBE92AF7@hornet.berlios.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 05 Dec 2005 21:54:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mhf@users.berlios.de> wrote:

[...]

> As to security, most vulnerabilities are hard to exploit 
> remotely

Right.

>          and practical security can be much more improved 
> by hiding detailed software versions from clients.

Ever heard of nmap <http://www.nmap.org>? Or perhaps noticed all kinds of
attacks against Linux using old exploits or Windows specific ones? Hiding
versions is /not/ secure. At most marginally so, and the pain for whoever
needs the version for legitimate reasons just isn't worth it.

>                                                     Apache 
> 2 on linux 2.6 will do instead of providing full vendor 
> specific package versions!
> 
> As to drivers, in case 3 month driver delay matters, HW 
> vendor can improve situation substantially  by not waiting 
> 6+ months before (if at all) releasing drivers/docs for 
> linux! 

For /server/ type workloads, where you /need/ stability, you carefully pick
the hardware and then run a selected "enterprise" distro on it. The distro
people do the hard work of keeping your kernel up to date and secure. And
even worry about a smooth upgrade to the next version. For a price, sure.
But either you really need it (and gladly pay the price) or you don't (in
which case you have nothing to complain about).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
