Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbULFSyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbULFSyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbULFSyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:54:12 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60300 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261617AbULFSxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:53:07 -0500
Message-Id: <200412061852.iB6IqaVV007399@laptop11.inf.utfsm.cl>
To: linux-os@analogic.com
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Imanpreet Singh Arora <imanpreet@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: What if? 
In-Reply-To: Message from linux-os <linux-os@chaos.analogic.com> 
   of "Mon, 06 Dec 2004 12:27:28 CDT." <Pine.LNX.4.61.0412061223010.18932@chaos.analogic.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 06 Dec 2004 15:52:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> said:
> On Sun, 5 Dec 2004, Horst von Brand wrote:

[...]

> > C++ is sufficiently not C that for such it is probably best to just
> > redesign the systems. Well done it is probably more elegant than C, but to
> > get there is a _lot_ of work.

> There is another problem. The kernel requires a procedural language
> to communicate with hardware. Interface with hardware is all about
> the step-by-step methods necessary to make hardware run. C++ tries
> to isolate one from the actual methods involved. That's what it
> was designed for.

If you want isolation. The actual methods (I'm assuming function members)
are written in procedural style if you want to.

> One would need to use "extensions" just to get text to the screen.  'C'
> being an "smart" assembler, is nearly ideal for kernel development.

And C++ is supposed to be an OO extension to C, designed to give a
(knowledgeable) programmer exactly the same low-level control as C when
needed (knowlegdeable, tasteful programmer is requisite).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
