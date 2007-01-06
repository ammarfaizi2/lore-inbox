Return-Path: <linux-kernel-owner+w=401wt.eu-S932123AbXAFT6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXAFT6F (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbXAFT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:58:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42916 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbXAFT6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:58:04 -0500
Message-Id: <200701061957.l06JvVbP007499@laptop13.inf.utfsm.cl>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Guilt 0.16 
In-Reply-To: Message from Josef Sipek <jsipek@fsl.cs.sunysb.edu> 
   of "Sat, 06 Jan 2007 13:46:39 CDT." <20070106184639.GC12543@filer.fsl.cs.sunysb.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sat, 06 Jan 2007 16:57:31 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:00:13 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 06 Jan 2007 16:58:02 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
> queues-like [1] functionality and interface to git.  The one distinguishing
> feature from other quilt-like porcelains, is the format of the patches
> directory. _All_ the information is stored as plain text - a series file and
> the patches (one per file). This easily lends itself to versioning the
> patches using any number of of SCMs.

A installation script/Makefile (or at least instructions) is missing...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
