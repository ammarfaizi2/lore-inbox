Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUFDSVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUFDSVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUFDSVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:21:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64721 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265909AbUFDSSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:18:37 -0400
Message-Id: <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl>
To: Pavel Machek <pavel@suse.cz>
cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Fri, 04 Jun 2004 15:58:16 +0200." <20040604135816.GD11950@elf.ucw.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 04 Jun 2004 14:17:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> said:

[...]

> You get pretty nasty managment problems. How do you do init=/bin/bash
> if your keyboard is userspace?

You don't tell any kernel about that... it is the bootloader you are
talking to. And that one may very well have integrated kbd support.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
