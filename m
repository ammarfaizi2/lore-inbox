Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTICWoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTICWoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:44:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5046 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264271AbTICWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:44:15 -0400
Date: Thu, 4 Sep 2003 00:44:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: USB modem no longer detected in -test4
Message-ID: <20030903224412.GA6822@atrey.karlin.mff.cuni.cz>
References: <20030903191701.GA2798@elf.ucw.cz> <20030903223936.GA7418@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903223936.GA7418@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In 2.6.0-test4, USB ELSA modem no longer works. This is UHCI (on
> > toshiba 4030cdt).
> > 
> > Relevant messages seem to be:
> > 
> > PM: Adding info for usb:1-1.2
> > drivers/usb/class/cdc-acm.c: need inactive config#2
> > PM: Adding info for usb:1-1.2:0
> > drivers/usb/class/cdc-acm.c: need inactive config#2
> 
> And this worked just fine in 2.6.0-test3?

It worked okay in 2.5.62, and probably in many later versions, but I'm
not sure if I specificaly tested it with -test3.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
