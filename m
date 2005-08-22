Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVHVWT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVHVWT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVHVWSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:18:50 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63367 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751349AbVHVWSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:18:46 -0400
Subject: Re: IRQ problem with PCMCIA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <58cb370e050822022556595fa1@mail.gmail.com>
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net>
	 <1124671082.1101.0.camel@localhost.localdomain>
	 <58cb370e050822022556595fa1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Aug 2005 11:32:50 +0100
Message-Id: <1124706770.7281.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-22 at 11:25 +0200, Bartlomiej Zolnierkiewicz wrote:
> CardBus IDE devices work just fine but there are still issues with
> hotplug support (work in progress).

"work in progress". Yes because I submitted working IDE cardbus hotplug
support, and Mark Lord submitted a Delkin driver both of which worked
months ago rather nicely and neither of which hit the Bartlomiej stone
wall and never got in and are now stale patches.

> > up ever getting those into the kernel. Please wait instead for the new
> > SATA/ATA layer to develop hotplug support.
> 
> This is just a FUD to discourage people from working on IDE drivers.
> Alan is doing this on purpose and doesn't really want to improve things.

Its a realistic assessment based upon over ten years working on the
Linux kernel. I do not believe you are capable of fixing the old IDE
code. But don't take that personally I am sceptical than anyone can fix
the old IDE code.

Alan

