Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264671AbUEEXGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbUEEXGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUEEXGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:06:31 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45249 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264671AbUEEXGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:06:30 -0400
Message-Id: <200405052306.i45N6IdS018945@eeyore.valparaiso.cl>
To: "Dominic VP" <dominic.vp@globaledgesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: build 
In-Reply-To: Your message of "Wed, 05 May 2004 19:23:59 +0530."
             <016101c432a8$6a64c520$630210ac@dominc> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Wed, 05 May 2004 19:06:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dominic VP" <dominic.vp@globaledgesoft.com> said:
> I am having to port linux to a new architecture. This architecture does not
> have gcc ported on to it. This does have an ansi c compiler.

Port gcc first. Lots of the kernel depend intimately on GCC-isms.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
