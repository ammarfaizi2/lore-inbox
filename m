Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVBAED0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVBAED0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBAED0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:03:26 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8343 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261528AbVBAEDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:03:23 -0500
Message-Id: <200502010055.j110tWbd022651@laptop11.inf.utfsm.cl>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] base-small: CONFIG_BASE_SMALL for small systems 
In-Reply-To: Message from Matt Mackall <mpm@selenic.com> 
   of "Mon, 31 Jan 2005 01:25:51 MDT." <1.687457650@selenic.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 31 Jan 2005 21:55:32 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> said:
> This patch series introduced a new pair of CONFIG_EMBEDDED options call
> CONFIG_BASE_FULL/CONFIG_BASE_SMALL. Disabling CONFIG_BASE_FULL sets
> the boolean CONFIG_BASE_SMALL to 1 and it is used to shrink a number
> of core data structures. The space savings for the current batch is
> around 14k.

Why _two_ config options?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
