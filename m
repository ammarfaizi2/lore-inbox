Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUCNRZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUCNRZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:25:22 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:60105 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S261453AbUCNRZV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:25:21 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [OOPS] Removing USB Bluetooth dongle Oopses 2.6.4
Date: Sun, 14 Mar 2004 18:23:41 +0100
User-Agent: KMail/1.6
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200403131351.44682.silla@netvalley.it> <1079200805.2142.4.camel@pegasus>
In-Reply-To: <1079200805.2142.4.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403141823.44223.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this looks like another unlink-during-submit bug in the uhci-hcd host
> driver. With the latest 2.6.4-bk2 the ohci-hcd is now free from it and
> an unplug works again without any oops or freezes. Post your oops to the
> USB developer mailing list.
>
> Regards
>
> Marcel

I've just tried 2.6.4-bk3 but the oops is still there; I'll forward it to the 
usb mailing list.

Regards, Silla
