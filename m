Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVCDQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVCDQWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVCDQWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:22:49 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:17339 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262912AbVCDQWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:22:41 -0500
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
In-Reply-To: <42287AC9.2050100@drzeus.cx>
References: <422701A0.8030408@drzeus.cx> <1109948432.8058.57.camel@pegasus>
	 <42287AC9.2050100@drzeus.cx>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 17:22:31 +0100
Message-Id: <1109953351.8058.82.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

> >lately I got a request for the support of a Bluetooth SD card. These are
> >using SDIO and I think at the moment only memory cards are handled. Do
> >you have any plans for SDIO support?
> 
> I would if I had some hardware to play with *hint* *hint* ;)

I don't have one of these cards either :(

> The SDIO spec is publically available on the SD card associations web 
> page so it shouldn't be too difficult to get some basic support. But I 
> can't do much as long as I don't have any hardware to test it with. I 
> might also need specs for the card itself. I haven't looked too much at 
> SDIO at the moment.

The Bluetooth HCI transport for SDIO is also available and I think most
SD card manufactures are using it.

So what we need is a hardware sponsor. Any volunteers?

Regards

Marcel


