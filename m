Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVC1Ow7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVC1Ow7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVC1Ow7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:52:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21985 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261813AbVC1Ow6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 09:52:58 -0500
Date: Mon, 28 Mar 2005 16:50:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os <linux-os@analogic.com>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
In-Reply-To: <Pine.LNX.4.61.0503280727310.19644@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0503281648210.7281@yvahk01.tjqt.qr>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
 <1112011441.27381.31.camel@localhost.localdomain>
 <Pine.LNX.4.61.0503280727310.19644@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What used to be done outside the kernel, the only reasonable
> place to do it, has now been moved inside the kernel for no
> other reason but isolation.

I would not complain as much if nvidia was "more userspace" so
that bug reports could be more valid than they are currently,
when they are tainted.



Jan Engelhardt
-- 
No TOFU for me, please.
