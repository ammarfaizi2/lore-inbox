Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272592AbTG3Bru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272615AbTG3Bru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:47:50 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:32918 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S272592AbTG3Brt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:47:49 -0400
Message-ID: <1059529817.3f27245977ef0@horde.sandall.us>
Date: Tue, 29 Jul 2003 18:50:17 -0700
From: sandalle@sandall.us
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: APIC error on CPU0: 02(02)
References: <1059528202.4820.12.camel@localhost>
In-Reply-To: <1059528202.4820.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn <core@enodev.com>:

> I just bought a shiny new Athlon 2400+ and popped it in my biostar M7VIB
> with an up to date bios.
> 
> I'm running 2.6.0-test1-mm2, and I get tons of "APIC error on CPU0:
> 02(02)" messages. Can someone tell me what is going on?
> 
> Info about my machine's hardware:
> http://www.enodev.com/info.html

I had the same problem on my Athlon-MP 2400+ on a Chaintech board (but my
Athlon-XP 2500+ on an nForce2 board booted fine) by disabling IO-APIC and SMP in
the kernel (I only have one processor atm).

-sandalle

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

