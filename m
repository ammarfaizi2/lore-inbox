Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTGQQOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271162AbTGQQOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:14:35 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:25510 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267724AbTGQQOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:14:34 -0400
Date: Thu, 17 Jul 2003 18:29:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       root@mauve.demon.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend on one machine, resume elsewhere [was Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
Message-ID: <20030717162906.GB446@elf.ucw.cz>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz> <20030716195129.A9277@informatik.tu-chemnitz.de> <20030716181551.GD138@elf.ucw.cz> <1058383043.6600.53.camel@dhcp22.swansea.linux.org.uk> <20030716223935.GF2684@wind.cocodriloo.com> <1058442562.8620.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058442562.8620.24.camel@dhcp22.swansea.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Would it not be a lot easier to tackle that with qemu, and teach qemu to
> > > freeze/restore virtual machines ?
> > 
> > AFAIK, qemu does virtual processes, but not virtual machines. Running init(1)
> > from qemu could be fun, anyways ;)
> 
> qemu moves on release by release. It can run an entire virtualised linux kernel
> nowdays, although its performance still needs some work.

I guess qemu is way too slow for this.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
