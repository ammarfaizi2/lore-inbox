Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVITSAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVITSAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVITSAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:00:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8662 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964782AbVITR77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:59:59 -0400
Message-Id: <200509201759.j8KHxkbj000577@laptop11.inf.utfsm.cl>
To: "Sean" <seanlkml@sympatico.ca>
cc: "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2 
In-Reply-To: Message from "Sean" <seanlkml@sympatico.ca> 
   of "Tue, 20 Sep 2005 11:20:46 -0400." <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice> <56402.10.10.10.28.1127229646.squirrel@linux1> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 20 Sep 2005 13:59:46 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 20 Sep 2005 13:59:47 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Tue, September 20, 2005 10:25 am, Gene Heskett said:
> 
> > Humm, what are they holding out for, more ram or more cpu?:-)
> >
> > FWIW, http://master.kernel.org doesn't show it either just now.

> While kernel.org snapshots will no doubt be working again shortly, you
> might want to consider using git.  It reduces the amount you have to
> download for each release a lot.

Only that it doesn't work either today. Kernel stays at 2.6.14-rc1 as of
yesterday (latest were a few NTFS patches), everything up to date.

BTW, the cogito repository is hosed, cg-update can't get needed object
69ba00668be16e44cae699098694286f703ec61d. Fetching the contents by rsync
gives the same mess.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
