Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWHQB1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWHQB1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 21:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWHQB1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 21:27:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58322 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932348AbWHQB1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 21:27:48 -0400
Message-Id: <200608170127.k7H1RZBQ003805@laptop13.inf.utfsm.cl>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: ext3 corruption 
In-Reply-To: Message from "Molle Bestefich" <molle.bestefich@gmail.com> 
   of "Sat, 12 Aug 2006 10:54:50 +0200." <62b0912f0608120154s1b158732y5da52b17583fdfa0@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Wed, 16 Aug 2006 21:27:35 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 16 Aug 2006 21:27:41 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich <molle.bestefich@gmail.com> wrote:
> Horst H. von Brand wrote:

[...]

> > The kernel people are certainly not infallible either. And there are cases
> > where the right order is A B C, and others in which it is C B A, and still
> > others where it doesn't matter.

> In the quite unlikely situation where that happens, you've obviously
> got a piece of software which is broken dependency-wise.  Many of the
> current schemes will fail to accommodate that too.

It isn't broken /software/, it is /different setups/.

> For example, no amount of moving the /etc/rc.d/rc6.d/K35smb script
> around will fix that situation on Red Hat.

What situation?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
