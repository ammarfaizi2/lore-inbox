Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSIJXzp>; Tue, 10 Sep 2002 19:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318223AbSIJXzp>; Tue, 10 Sep 2002 19:55:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318222AbSIJXzp>;
	Tue, 10 Sep 2002 19:55:45 -0400
Subject: Problems with 2.4 and 2.5 with KVM/mouse
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 17:00:31 -0700
Message-Id: <1031702431.3086.36.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two machines on a KVM and when I switch between them the mouse
pointer goes wacky and causes random clicks. This has always been
somewhat of a problem when both machines were running 2.4 but there was
a workaround.  If I switched consoles (alt-F1, alt-F7) then the mouse
would restore back to correct behaviour. 

Now, on my test machine running 2.5 the mouse works until I do a KVM
machine swap. Then the 2.5 machine never clears up the mouse wackiness
and the only choice is to reboot. 

The mouse is a Logitech optical mouse with a wheel "Wheel mouse". The
mouseconfig is the same on both machines. The KVM is a Belkin four port.

Probably the simplest is to buy another mouse or switch to USB...



