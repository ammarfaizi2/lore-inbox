Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTDGM0g (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263414AbTDGM0g (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:26:36 -0400
Received: from chii.cinet.co.jp ([61.197.228.217]:21378 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263413AbTDGM0f (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 08:26:35 -0400
Date: Mon, 7 Apr 2003 21:36:16 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.66-ac2] PC-9800 sub architecture support (5/9) IDE
Message-ID: <20030407123616.GA5734@yuzuki.cinet.co.jp>
References: <20030407033627.GA4798@yuzuki.cinet.co.jp> <20030407035231.GE4840@yuzuki.cinet.co.jp> <1049715151.2965.40.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049715151.2965.40.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 12:32:32PM +0100, Alan Cox wrote:
> On Llu, 2003-04-07 at 04:52, Osamu Tomita wrote:
> > This is the patch to support NEC PC-9800 subarchitecture
> > against 2.5.66-ac2. (5/9)
> > 
> > PC98 standard IDE I/F support.
> >  - Change default IO port address and IRQ.
> >  - Request region exactly for other optional cards.
> 
> I'm ignoring this one for the moment because one of the jobs I need
> to do is to move all the resource handling in IDE into the drivers
> not the core code. When that is done the problem goes away
I see.

Thanks,
Osamu Tomita

