Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUCKUij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUCKUfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:35:07 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50910 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261657AbUCKUd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:33:57 -0500
Message-Id: <200403112033.i2BKX9B6005538@eeyore.valparaiso.cl>
To: Christophe Saout <christophe@saout.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LKM rootkits in 2.6.x 
In-Reply-To: Your message of "Thu, 11 Mar 2004 20:16:28 BST."
             <1079032587.7517.1.camel@leto.cs.pocnet.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 11 Mar 2004 17:33:09 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> said:
> Am Do, den 11.03.2004 schrieb Dave Jones um 19:48:

> > Don't bet on it.  They'll just start doing what binary-only driver vendors
> > have been doing for months.. If the table isn't exported, they find a
> > symbol that is exported, and grovel around in memory near there until
> > they find something that looks like it, and patch accordingly.

> Ugh... this sounds ugly. This should be forbidden. I mean, what are
> things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
> whatever they want?

It _is_ forbidden. This isn't any kind of accident we are talking about,
this is out and out fraud.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
