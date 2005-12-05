Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVLEJGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVLEJGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 04:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLEJGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 04:06:12 -0500
Received: from ns.firmix.at ([62.141.48.66]:30363 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751088AbVLEJGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 04:06:10 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <43938D40.7040804@wolfmountaingroup.com>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <1133630556.22170.26.camel@laptopd505.fenrus.org>
	 <20051203230520.GJ25722@merlin.emma.line.org>
	 <43923DD9.8020301@wolfmountaingroup.com>
	 <1133732132.3317.32.camel@gimli.at.home>
	 <43938D40.7040804@wolfmountaingroup.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 05 Dec 2005 10:06:07 +0100
Message-Id: <1133773567.22753.15.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Minimized quoted part ]
On Sun, 2005-12-04 at 17:43 -0700, Jeff V. Merkey wrote:
> Bernd Petrovitsch wrote:
> >On Sat, 2005-12-03 at 17:52 -0700, Jeff V. Merkey wrote:
[...]
> >>of this code. I have apps written for Windows in 1990 and 1998 that 
> >                       ^^^^
> >>still run on Windows XP today. Linux has no such concept of
> >
> >But this not even holds for nearly all apps.
> >
> >>backwards compatiblity. Every company who has embraced it outside of 
> >
> >The same holds (probably) for Linux apps (given that your kernel can
> >start a.out). And AFAIBT by Win* driver developers even in the Win*
> >world you have to change your driver because of a new Win* version now
> >and then.
[...]
> No.  BIND was has been busted between 2.4 and 2.6.  Not to mention the

Hmmm, URL? Details? I can't remember anything about such issues.

> whole libc -> glib switchover.

glib has AFAIK next to nothing to do with a libc AFAICT (i.e. it is
using standard libc functions but that's all).

> It's hilarious that BSD had to create a Linux app compat lib, and the 
> RedHat shipped compat libs for 3 releases

Here you have your backwards compatibility.

> as well.   Not even close.  Windows has won.  M$ has won.  Linux lost 
> the desktop wars and will soon loose
> the server wars as well.   The reason - infighting and lack of backwards 

Yes, probably - MSFT is spreading the same story since ages.

> compatibility.  Binary only module
> breakage kernel to kernel will continue. 

As other told there never was a stable kernel module interface. Of
course there is probably enough willing manpower out there who will work
on that once you pay them. Or you can provide such support on your own.

Or do you (or anybody else) has drivers which should be maintained for
vanilla-kernel and/or vendor kernels and/or other kernels (to fix the
breakage in a cosntructive way), we can provide you with an offer to do
that.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

