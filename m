Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUFHM1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUFHM1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFHM1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:27:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46032 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265112AbUFHM1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:27:47 -0400
Message-Id: <200406080057.i580v6Gp005332@eeyore.valparaiso.cl>
To: ckkashyap@spymac.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: building MINIX on LINUX using gcc 
In-Reply-To: Your message of "Mon, 07 Jun 2004 00:14:07 CST."
             <20040607061407.37FF54C0BE@spy10.spymac.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 07 Jun 2004 20:57:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<ckkashyap@spymac.com> said:
> I would like to build the MINIX kerenel on a LINUX machine using gcc +
> nasm!

Minix is 8086 (64KiB maximum segment size, etc). You might try to run Minix
under dosemu, though...

> Is there MINIX source that is buildable on LINUX platform available?

I doubt it. It would need a _lot_ of tweaking to build, or you'd have to
build your own tools targeting 8086.
