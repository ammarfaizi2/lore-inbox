Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVLSRGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVLSRGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVLSRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:06:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:10380 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964863AbVLSRGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:06:39 -0500
Date: Mon, 19 Dec 2005 09:00:35 -0800
From: Greg KH <greg@kroah.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14.3] S3 and USB
Message-ID: <20051219170035.GB1911@kroah.com>
References: <200512161535.13650.lkml@kcore.org> <20051216191648.GA4796@kroah.com> <200512190819.41051.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512190819.41051.lkml@kcore.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 08:19:40AM +0100, Jan De Luyck wrote:
> On Friday 16 December 2005 20:16, Greg KH wrote:
> > On Fri, Dec 16, 2005 at 03:35:13PM +0100, Jan De Luyck wrote:
> >
> > > USB and the like work without problems. The only problem I have is that
> > > if I leave USB 'on' and suspend, any activity to the USB ports causes my
> > > laptop to resume but it never resumes correctly. I get a black screen, no
> > > entries in the system logs, and I need to hold the power button to power
> > > off the machine. Which is very annoying since I tend to plug in my USB
> > > mouse before I open the screen.
> >
> > Can you try 2.6.15-rc5?  USB suspend issues are still being worked out
> 
> Thanks for the pointer, I installed 2.6.15-rc6 today and everything seems 
> fine. The laptop resumes nicely no matter what happens on the USB ports.

Great, thank you very much for testing and letting us know.

greg k-h
