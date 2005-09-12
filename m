Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVILTlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVILTlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVILTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:41:18 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41151 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932172AbVILTlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:41:17 -0400
Message-Id: <200509121940.j8CJegwe019443@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs-Dev@namesys.com, reiserfs-list@namesys.com
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review) 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Mon, 12 Sep 2005 11:08:37 MST." <4325C425.4030002@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 12 Sep 2005 15:40:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 12 Sep 2005 15:40:42 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Andrew Morton wrote:
> >The type-unsafety of existing list_heads gives me conniptions too.  Yes,
> >it'd be nice to have a type-safe version available.

[...]

> Vladimir spent 24 hours straight unsafing the lists in reiser4, and
> didn't finish yet.  We need 1-2 more days to address this before we can
> submit reiser4.  I hope this delay will not be too much of a problem.

It won't go in before 2.6.15 or so anyway, so...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
