Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTK0Xee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTK0Xee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:34:34 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:59791 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261681AbTK0Xed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:34:33 -0500
From: Duncan Sands <baldrick@free.fr>
To: Vladimir Lazarenko <vlad@lazarenko.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9/10 speedtouch glitch
Date: Fri, 28 Nov 2003 00:01:30 +0100
User-Agent: KMail/1.5.4
References: <200311272023.56413.vlad@lazarenko.net> <200311272143.05662.baldrick@free.fr> <200311272339.26205.vlad@lazarenko.net>
In-Reply-To: <200311272339.26205.vlad@lazarenko.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311280001.30220.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 23:39, Vladimir Lazarenko wrote:
> On Thursday 27 November 2003 21:43, Duncan Sands wrote:
> > > Dunno if this has been mentioned already, but I have an interesting
> > > glitch with speedtouch DSL modem. When i compile the driver as module,
> > > it says registered driver speedtouch, but can not access the device.
> > >
> > > However, when i compile the driver in, everything works smoothly and
> > > nicely. If you need some more testing/information do not hesitate to
> > > contact me.
> >
> > Try the latest hotplug scripts.
>
> Using Debian/sid with latest available usbmgr.
> Tho the module itself loads successfully, just that modem_run isn't able to
> see the device, I think at that point hotplug has to complete already?

What error message do you get exactly?  When running what command?

Thanks,

Duncan.
