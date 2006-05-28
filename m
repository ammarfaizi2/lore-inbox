Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWE1GpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWE1GpX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 02:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWE1GpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 02:45:23 -0400
Received: from 1in1.de ([85.214.39.241]:2723 "EHLO 1in1.de")
	by vger.kernel.org with ESMTP id S1750726AbWE1GpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 02:45:23 -0400
Message-ID: <447946F8.9090407@1in1.de>
Date: Sun, 28 May 2006 08:45:12 +0200
From: =?ISO-8859-1?Q?Jens_G=F6tze?= <jens.goetze@1in1.de>
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux and Wireless USB Adaptor
References: <44793F44.1040603@perkel.com>
In-Reply-To: <44793F44.1040603@perkel.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=DA519E6B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam: no
X-note: out-remsmtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

I would try ndiswrapper (http://ndiswrapper.sf.net), because it is the
easiest way to run a USB Wireless LAN adapter. The ndiswrapper is a nice
driver, which allows to run Windows NDIS Driver under Linux. Therefore,
you can use the delivered Windows Driver to run your adapter under
Linux. I use for all my wireless adapter this kind of solution. But
maybe it exists a better way to run your adapter under Linux (separate
linux driver or so).
If you need help to install ndiswrapper you should take a look on the
project website.

Regards,
Jens

Marc Perkel wrote:
> I have an Airlink Wireless USB 2.0 adaptor. Does it work with Linux? If
> so - what do I have to do to make it work?
> 
> Thanks in advance.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
