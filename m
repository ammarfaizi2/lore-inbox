Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVLLBhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVLLBhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVLLBgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:36:55 -0500
Received: from quelen.inf.utfsm.cl ([200.1.19.194]:15086 "EHLO
	quelen.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1750996AbVLLBgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:36:47 -0500
Message-Id: <200512111626.jBBGQoEB014724@quelen.inf.utfsm.cl>
To: Rob Landley <rob@landley.net>
cc: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel] 
In-Reply-To: Message from Rob Landley <rob@landley.net> 
   of "Sat, 10 Dec 2005 23:30:30 MDT." <200512102330.31572.rob@landley.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Sun, 11 Dec 2005 13:26:50 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> wrote:

[...]

> There is an interesting licensing issue, creating a linux kernel image that 
> contains an initramfs that contains binary only firmware.  I can happily 
> generate one here and not care, but does distributing such a kernel violate 
> the GPL?

Some distributions (e.g. INSERT) ship a CD image with ipw2x00 firmware.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

