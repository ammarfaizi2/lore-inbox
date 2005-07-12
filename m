Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVGLUWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVGLUWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVGLUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:22:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5086 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262363AbVGLUUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:20:06 -0400
Message-Id: <200507122019.j6CKJwxe021850@laptop11.inf.utfsm.cl>
To: Konstantin Kudin <konstantin_kudin@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean? 
In-Reply-To: Message from DervishD <lkml@dervishd.net> 
   of "Tue, 12 Jul 2005 19:37:21 +0200." <20050712173721.GA325@DervishD> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 12 Jul 2005 16:19:58 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 12 Jul 2005 16:20:03 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> wrote:

[...]

>     It's a good idea to have a copy of the partition table around, if
> it is not simple (the one you had is NOT simple).

Be careful. What you'll get out of backing up the partition table is /only/
the primary partitions, the others are handled by a weird russian doll of
partitions-inside-partitions. AFAIR, the details were in the LILO docu.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
