Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUCPSwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCPSvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:51:31 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26836 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261215AbUCPStt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:49:49 -0500
Message-Id: <200403161849.i2GInfF0007372@eeyore.valparaiso.cl>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent? 
In-Reply-To: Your message of "Tue, 16 Mar 2004 17:46:11 +0200."
             <20040316154611.GA31510@mulix.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 16 Mar 2004 14:49:41 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> said:

[...]

> This is something that I've thought of doing in the past. The reason I
> didn't pursue it further is that it's impossible to get it right for
> all cases, and it attacks the problem in the wrong place. The kernel
> shouldn't need to guess(timate) what the process is going to do. The
> userspace programmer, who knows what his process is going to do,
> should tell the kernel.

People have been known to lie on occasion, particularly when it is to their
advantage...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
