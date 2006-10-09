Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWJIBvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWJIBvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 21:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWJIBvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 21:51:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62439 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751589AbWJIBvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 21:51:12 -0400
Message-Id: <200610090149.k991niYB009787@laptop13.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: known regressions (v2) 
In-Reply-To: Message from Jan-Benedict Glaw <jbglaw@lug-owl.de> 
   of "Sun, 08 Oct 2006 19:34:46 +0200." <20061008173445.GN30283@lug-owl.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 08 Oct 2006 21:49:44 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 08 Oct 2006 21:49:47 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Sun, 2006-10-08 19:28:59 +0200, Adrian Bunk <bunk@stusta.de> wrote:

[...]

> I'd find it offensive, too, when I'd be called "guilty" because a
> patch broke something that was buggy. Read the bug report: Seems it
> was actually caused by a non-initialized variable introduced by a
> patch to util-linux.
> 
> > This wasn't my intention, and I've replaced it with "Caused-By".
> 
> Made-visible-by :)

Git-bisected-to?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
