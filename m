Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVACVG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVACVG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVACVDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:03:23 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47066 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261871AbVACVCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:02:01 -0500
Message-Id: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
To: Felipe Alfaro Solana <lkml@mac.com>
cc: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7 
In-Reply-To: Message from Felipe Alfaro Solana <lkml@mac.com> 
   of "Mon, 03 Jan 2005 18:39:32 BST." <6D2C0E07-5DAE-11D9-9FD3-000D9352858E@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 03 Jan 2005 17:59:24 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <lkml@mac.com> said:

[...]

> I would like to comment in that the issue is not exclusively targeted 
> to stability, but the ability to keep up with kernel development. For 
> example, it was pretty common for older versions of VMWare and NVidia 
> driver to break up whenever a new kernel version was released.

That is the price for closed-source drivers.

> I think it's a PITA for developers to rework some of the closed-source 
> code to adopt the new changes in the Linux kernel.

Open up the code. Most of the changes will then be done as a matter of
course by others.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
