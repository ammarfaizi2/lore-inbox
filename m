Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268180AbTAKWH3>; Sat, 11 Jan 2003 17:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268181AbTAKWH3>; Sat, 11 Jan 2003 17:07:29 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:260
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S268180AbTAKWH2> convert rfc822-to-8bit; Sat, 11 Jan 2003 17:07:28 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Sat, 11 Jan 2003 17:18:07 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB problems on ASUS A7M266-D with kernel 2.4.20
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200301111718.07209.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this board, but the problem is the newer A7M266-D boards have the USB 
1.x pins removed. 

Also, I cannot get USB working with 2.4 it fails on assignment of irq routing.

2.5 does find my USB but I have issues with it right now ;(

Shawn.

>List:     linux-kernel
>Subject:  USB problems on ASUS A7M266-D with kernel 2.4.20
From:     "=?iso-8859-1?Q?Philip_K.F._H=F6lzenspies?="
>Date:     2003-01-11 18:25:02

>Hi,

>I can't seem to figure this out. I have an A7M266-D (with the 760MPX AMD
>chipset, with the busted USB-controller, but with a pci replacement
>board) with 2 AMD Athlon 1800 XP CPUs. One way or another, whatever I
>do, I can't see USB devices. In my case, it mainly concerns my Logitech
>MouseMan Dual Optical. I have HID, EHCI, UHCI and OHCI compiled into the
>kernel (kernel config file included at the bottom) and still don't get
>anything in my /proc/bus/usb/ other than 'devices' and 'drivers' and
>they don't tell me very much either (see below).

>Did anybody else encounter this problem, or is it a Logitech specific
>issue?

>Regards,
>Philip K.F. Hölzenspies
