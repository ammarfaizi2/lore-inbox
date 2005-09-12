Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVILV1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVILV1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVILV1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:27:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49097 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932248AbVILV1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:27:20 -0400
Message-Id: <200509122127.j8CLR3n7025719@laptop11.inf.utfsm.cl>
To: Valdis.Kletnieks@vt.edu
cc: Hugh Dickins <hugh@veritas.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Tainted lsmod output 
In-Reply-To: Message from Valdis.Kletnieks@vt.edu 
   of "Mon, 12 Sep 2005 16:16:45 -0400." <200509122016.j8CKGjmY029390@turing-police.cc.vt.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 12 Sep 2005 17:27:03 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 12 Sep 2005 17:27:04 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 12 Sep 2005 20:58:01 BST, Hugh Dickins said:
> > On Mon, 12 Sep 2005, Randy.Dunlap wrote:
> > > On Mon, 12 Sep 2005, Hugh Dickins wrote:
> > > > The one that puzzles me greatly isn't listed there: 'G'

> > > I guess it means GPL.
> > > 
> > > It's just the opposite of 'P', whereas all of the others
> > > have opposites of ' '.

> > I guess the same, but doesn't it seem a strange kind of taint?

> Somebody had an automated log-parsing tool, and wanted to make sure there
> were guaranteed at least 2 non-whitespace tokens on the line so they wouldn't
> have to deal with parsing 'Tainted:       \n'?

That's a lame excuse for messing up the kernel and mistifying the heck out
of users. Either "Tainted: <some gunk>" or "Not tainted" (or just nothing)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
