Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUCKUrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUCKUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:42:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55521 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261748AbUCKUmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:42:05 -0500
Message-Id: <200403112042.i2BKg31f005645@eeyore.valparaiso.cl>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LKM rootkits in 2.6.x 
In-Reply-To: Your message of "Thu, 11 Mar 2004 14:30:09 CDT."
             <200403111930.i2BJU9oh004246@turing-police.cc.vt.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 11 Mar 2004 17:42:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> said:
> On Thu, 11 Mar 2004 20:16:28 +0100, Christophe Saout said:
> 
> > Ugh... this sounds ugly. This should be forbidden. I mean, what are
> > things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
> > whatever they want?
> 
> If the binary blob knows enough about the innards to be able to do binary
> patching, it's a derived work and should be GPL.

You are more than wellcome to use it as you see fit, and distribute it as
widely as you can ;-)

> Even the NVidia driver isn't *that* evil... :)

:-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
