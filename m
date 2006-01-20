Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWATWzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWATWzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWATWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:55:55 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45021 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932287AbWATWzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:55:54 -0500
Message-Id: <200601202254.k0KMsls1011155@laptop11.inf.utfsm.cl>
To: Michael Loftis <mloftis@wgops.com>
cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE? 
In-Reply-To: Message from Michael Loftis <mloftis@wgops.com> 
   of "Fri, 20 Jan 2006 09:07:16 PDT." <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 20 Jan 2006 19:54:47 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 20 Jan 2006 19:55:50 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis <mloftis@wgops.com> wrote:

[...]

> Lots of things still out there depend on devfs.

Nothing in the regular kernel, nothing in any sane distribution.

devfs has been slated for the axe for a /very/ long time.

>                                                  So now if I want to
> develop my kmod on recent kernels I have to be in the business of
> maintaining a lot more userland stuff, like mkinitrd, installers,
> etc. that have come to rely on devfs.

Your own fault that you didn't heed the warnings about stuff to be deleted
and didn't keep up with the regular development around the kernel. Not the
kernel hackers' responsibility.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
