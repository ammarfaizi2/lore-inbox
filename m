Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUIARzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUIARzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIARwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:52:18 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60866 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267365AbUIAPyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:54:47 -0400
Message-Id: <200409011340.i81DeAqZ004466@laptop11.inf.utfsm.cl>
To: Prasad <prasad@atc.tcs.co.in>
cc: "Wise, Jeremey" <jeremey.wise@agilysys.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug. 
In-Reply-To: Message from Prasad <prasad@atc.tcs.co.in> 
   of "Wed, 01 Sep 2004 09:58:53 +0530." <41355005.6030204@atc.tcs.co.in> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 01 Sep 2004 09:40:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad <prasad@atc.tcs.co.in> said:
> "Wise, Jeremey" <jeremey.wise@agilysys.com> said:
> >"Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)" 

> This indicates that the kernel is not able to find the root partition.
> and that the kernel has already booted - most likely not a problem with 
> GRUB.

Might be a broken/missing initrd, or the module(s) for the root filesystem
missing in your build.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
