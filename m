Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTK0Wjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTK0Wjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 17:39:45 -0500
Received: from smtp4.wanadoo.nl ([194.134.35.175]:57888 "EHLO smtp4.wanadoo.nl")
	by vger.kernel.org with ESMTP id S261368AbTK0Wjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 17:39:44 -0500
From: Vladimir Lazarenko <vlad@lazarenko.net>
Organization: Favoretti Spagettolino Inc
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9/10 speedtouch glitch
Date: Thu, 27 Nov 2003 23:39:25 +0100
User-Agent: KMail/1.5.93
Cc: Duncan Sands <baldrick@free.fr>
References: <200311272023.56413.vlad@lazarenko.net> <200311272143.05662.baldrick@free.fr>
In-Reply-To: <200311272143.05662.baldrick@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200311272339.26205.vlad@lazarenko.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 21:43, Duncan Sands wrote:
> > Dunno if this has been mentioned already, but I have an interesting
> > glitch with speedtouch DSL modem. When i compile the driver as module, it
> > says registered driver speedtouch, but can not access the device.
> >
> > However, when i compile the driver in, everything works smoothly and
> > nicely. If you need some more testing/information do not hesitate to
> > contact me.
>
> Try the latest hotplug scripts.

Using Debian/sid with latest available usbmgr.
Tho the module itself loads successfully, just that modem_run isn't able to 
see the device, I think at that point hotplug has to complete already?

> Duncan.

-- 
Best regards,
Vladimir Lazarenko
