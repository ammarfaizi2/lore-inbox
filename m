Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVBXNZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVBXNZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVBXNZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:25:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23510 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262347AbVBXNZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:25:39 -0500
Message-Id: <200502241325.j1ODPJCa028359@laptop11.inf.utfsm.cl>
To: Hugh Dickins <hugh@veritas.com>
cc: "Ammar T. Al-Sayegh" <ammar@kunet.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:483! 
In-Reply-To: Message from Hugh Dickins <hugh@veritas.com> 
   of "Wed, 23 Feb 2005 21:31:16 -0000." <Pine.LNX.4.61.0502232108500.14780@goblin.wat.veritas.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 24 Feb 2005 10:25:19 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 24 Feb 2005 10:25:21 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> said:
> On Wed, 23 Feb 2005, Ammar T. Al-Sayegh wrote:
> > I recently installed Fedora RC3 on a new server.
> > The kernel is 2.6.10-1.741_FC3smp.

> I can't really speak for Fedora RC3 kernels,
> perhaps there's some special patch in there that happens to
> trigger it for you, but certainly there have been occasional
> other reports of this BUG with vanilla kernel.org kernels.

That kernel is outdated, current is 2.6.10-1.766_FC3. Before reporting any
bugs, update everything! And in case of problems with vendor kernels, it is
more useful for everybody involved to report to the distribution.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
