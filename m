Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbUCNEXC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbUCNEXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:23:02 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1470 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263274AbUCNEXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:23:00 -0500
Message-Id: <200403140421.i2E4KsqA022567@eeyore.valparaiso.cl>
To: Ian Kent <raven@themaw.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs 
In-Reply-To: Your message of "Sun, 14 Mar 2004 10:33:00 +0800."
             <Pine.LNX.4.58.0403141032230.4585@raven.themaw.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 14 Mar 2004 00:20:53 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> dijo:
> On Thu, 11 Mar 2004, Miklos Szeredi wrote:
> 
> > 
> > I'll have to, as this is needed for AVFS.  Not unionfs, but something
> > similar, that allows file/directory lookups for special filenames to
> > be redirected to another filesystem.
> 
> I have a need for this in autofs4 also.

At least some Unices have context-dependent symlinks, and AFAIR there was
something like this in Linux a _long_ while back (perhaps just in Red Hat,
must have been the second half of the '90s). It was discarded as too much
mess (in kernel, in userspace, and in wetware) for little gain, IIRC.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
