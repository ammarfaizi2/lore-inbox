Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264075AbTCXDBx>; Sun, 23 Mar 2003 22:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264081AbTCXDBx>; Sun, 23 Mar 2003 22:01:53 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:53975 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S264075AbTCXDBw>;
	Sun, 23 Mar 2003 22:01:52 -0500
Subject: USB keyboard problems. 2.4.x and 2.5.x
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048475600.907.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Mar 2003 04:13:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've been running 2.5.x on my desktop the last months. It's working
great! But I had one issue with 2.4.x that 2.5.x hasn't solved. I can't
the the usb-keyboard working right.

I have an usb-printer, usb-scanner, usb-bluetooth and usb-serial, all of
them working like a charm. When I plug in the keyboard when my computer
is running, it works allright. (When I have booted with PS/2). But if I
boot with the keyboard inserted, I get the message "device not accepting
address". I have seen the faq on linux-usb.org, but I'm not able to boot
the pc without the noapic option.

The motherboard is a Asus CUV266-DLS dual P3 with integrated SCSI and
LAN. 

Anyone know what the problem is, or what I should try? It's kinda weird
that it works without hassle if I plug in it when running, but it won't
work when booting. Hmm.

Best regards,
Stian

