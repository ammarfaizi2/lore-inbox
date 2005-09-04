Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVIDWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVIDWDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVIDWDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:03:06 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1729 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932084AbVIDWDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:03:05 -0400
Message-Id: <200509041922.j84JMVmI003942@laptop11.inf.utfsm.cl>
To: bas.westerbaan@gmail.com
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Paul Misner <paul@misner.org>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS 
In-Reply-To: Message from Bas Westerbaan <bas.westerbaan@gmail.com> 
   of "Sun, 04 Sep 2005 19:12:33 +0200." <6880bed305090410127f82a59f@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Sep 2005 15:22:31 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Westerbaan <bas.westerbaan@gmail.com> wrote:
> > Yes you are. You're asking for 4KSTACKS config option to maintained
> > and it is not something you get for free. Besides, if it is indeed
> > ripped out of mainline kernel, you can always keep it a separate patch
> > for ndiswrapper.

> Though 4K stacks are used a lot, they probably aren't used on all
> configurations yet. Other situations may arise where 8K stacks may be
> preferred. It is too early to kill 8K stacks imho.

At least Fedora ships 4Kstacks kernel for quite a while now. No, it is not
"everywhere", but close.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
