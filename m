Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265923AbUFDSkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUFDSkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbUFDSkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:40:18 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:47489 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265923AbUFDSkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:40:07 -0400
Date: Fri, 4 Jun 2004 20:39:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040604183944.GK700@elf.ucw.cz>
References: <20040604135816.GD11950@elf.ucw.cz> <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [...]
> 
> > You get pretty nasty managment problems. How do you do init=/bin/bash
> > if your keyboard is userspace?
> 
> You don't tell any kernel about that... it is the bootloader you are
> talking to. And that one may very well have integrated kbd support.

I know bootloader will hae its own kbd driver.

But when kernel boots, you'll not be able to enter commands into the bash.
-- 
934a471f20d6580d5aad759bf0d97ddc
