Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVFHRjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVFHRjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVFHRjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:39:19 -0400
Received: from [217.170.8.20] ([217.170.8.20]:18199 "EHLO
	mail.research.newtrade.nl") by vger.kernel.org with ESMTP
	id S261456AbVFHRiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:38:09 -0400
Subject: Re: USB errors causes system to become unresponsive
From: Duncan Sands <baldrick@free.fr>
To: Bharath Ramesh <krosswindz@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c775eb9b0506081027d0cc6b9@mail.gmail.com>
References: <c775eb9b0506081027d0cc6b9@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 19:38:07 +0200
Message-Id: <1118252287.8844.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am running the 2.6 kernel and I notice that every now and then my
> system stops responding but is still accessible remotely through ssh.
> I can not work on the console. The only way out is to reboot either
> remotely or by hitting the reset button. When the system comes up
> again I get the following message in my dmesg and I need to actually
> reboot it once or twice before this error goes. of I get a spew of
> following messages. These messages don't stop till I reboot the
> machine.
> 
> drivers/usb/input/hid-core.c: input irq status -75 received

What usb devices do you have plugged in?

D.

