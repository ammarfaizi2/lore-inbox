Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVGLD1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVGLD1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGLD1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:27:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58041 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262261AbVGLD1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:27:15 -0400
Message-Id: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl>
To: Marc Aurele La France <tsi@ualberta.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel header policy 
In-Reply-To: Message from Marc Aurele La France <tsi@ualberta.ca> 
   of "Mon, 11 Jul 2005 15:37:47 CST." <Pine.BSO.4.61.0507111533340.23021@login3.srv.ualberta.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 11 Jul 2005 22:06:46 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Aurele La France <tsi@ualberta.ca> wrote:
> It has been more than a week now...

> ---------- Forwarded message ----------
> Date: Sun, 3 Jul 2005 11:12:03 -0600 (MDT)
> From: Marc Aurele La France <tsi@ualberta.ca>
> To: Linus Torvalds
> Subject: Kernel header policy

[....]

> I am contacting you to express my concern over a growing trend in kernel
> development.  I am specifically referring to changes being made to kernel
> headers that break compatibility at the userland level, where __KERNEL__
> isn't #define'd.

The policy with respect to kernel headers is /very/ simple:

  T H E Y   A R E   N E V E R   U S E D   F R O M   U S E R L A N D.

This general policy makes all your points (trivially) moot.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
