Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVDDScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVDDScW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVDDScV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:32:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2711 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261322AbVDDScP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:32:15 -0400
Message-Id: <200504041832.j34IW6PO030096@laptop11.inf.utfsm.cl>
To: Jonas Diemer <diemer@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: security issue: hard disk lock 
In-Reply-To: Message from Jonas Diemer <diemer@gmx.de> 
   of "Mon, 04 Apr 2005 19:42:10 +0200." <200504041942.10976.diemer@gmx.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 04 Apr 2005 14:32:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 04 Apr 2005 14:32:07 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonas Diemer <diemer@gmx.de> said:

[...]

> I figured there could be a kernel compiled-in option that will make the
> kernel lock all drives found during bootup. then, a malicous program
> would need to install a different kernel in order to harm the drive,
> which would be much more secure.

Doing it in initrd should be plenty of time, no need to involve the kernel.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
