Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWG1OCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWG1OCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWG1OCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:02:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37576 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161160AbWG1OCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:02:44 -0400
Message-Id: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
To: Jeff Garzik <jeff@garzik.org>
cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion) 
In-Reply-To: Message from Jeff Garzik <jeff@garzik.org> 
   of "Fri, 28 Jul 2006 07:15:11 -0400." <44C9F1BF.7040003@garzik.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 28 Jul 2006 10:02:04 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 28 Jul 2006 10:02:05 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:

[...]

> It is then simple to follow that train of logic:  why not make it easy
> to replace the directory algorithm [and associated metadata]?  or the
> file data space management algorithms?  or even the inode handling?
> why not allow customers to replace a stock algorithm with an exotic,
> site-specific one?

IMVHO, such experiments should/must be done in userspace. And AFAICS, they
can today.

Go wild, but leave the kernel alone.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
