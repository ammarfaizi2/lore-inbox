Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUGTTen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUGTTen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUGTTeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:34:23 -0400
Received: from moonshine.cih.com ([204.69.206.3]:36507 "EHLO mail.cih.com")
	by vger.kernel.org with ESMTP id S266166AbUGTTdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:33:13 -0400
Date: Tue, 20 Jul 2004 12:33:12 -0700 (PDT)
From: "Craig I. Hagan" <hagan@cih.com>
To: David Lazanja <lazanja@plasma.ap.columbia.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: firewire drive / sbp2 module
In-Reply-To: <200407190231.19269.lazanja@plasma.ap.columbia.edu>
Message-ID: <Pine.LNX.4.58.0407201226250.25199@svr.cih.com>
References: <200407190231.19269.lazanja@plasma.ap.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I compiled 2.6.7 using the configuration from suse's 2.6.5-7.95-default kernel 
> but still have no success.  All of the correct modules are loading.

I'm using stock 2.6.7 on top of gentoo and have had no problems with firewire
drives (i'm using a pci fw card)

> >From the kernel messages (below), it seems that sbp2 is failing.  I was 
> looking around on the list and found some others are also having problems
> with sbp2.  I'm trying to find out if this is a known general problem under 
> 2.6 or if it's specific to the drive that I'm using (Buslink 80GB usb2 / 
> firewire combo).

I've not had problems with 2.6.x and firewire, otoh, i'm running pci vs. pcmcia
devices. have you confirmed your drive works on a different system or os?

-- craig
