Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHWXOJ>; Fri, 23 Aug 2002 19:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSHWXOJ>; Fri, 23 Aug 2002 19:14:09 -0400
Received: from mail.xiotech.com ([209.46.118.18]:61197 "EHLO
	packer.xiotech.com") by vger.kernel.org with ESMTP
	id <S313711AbSHWXOI>; Fri, 23 Aug 2002 19:14:08 -0400
Message-ID: <ED8EDD517E0AA84FA2C36C8D6D205C1303F1C2FE@alfred.xiotech.com>
From: "Brueggeman, Steve" <steve_brueggeman@xiotech.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Anyone know how to get soft-power-down to work on an Intel SCB2??
Date: Fri, 23 Aug 2002 18:18:08 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot find any way, via BIOS, or utilities to check/select the
power-management scheme.

Their documentation says they support soft-power-off, but I certainly cannot
figure out how to do it.

The SCB2 only has one processor, and the kernel is compiled for single
processor.   I've enabled APM and ACPI, and the exact same binaries (kernel
and modules) work on 4 different machines, and do soft-power-off them, and
one of them WAS a dual processor system.

So, I'm hoping that someone out there has figured out this problem.

I've even tried the patches for acpi on sourceforge.net.  They didn't help,
and seemed to make the kernel MUCH more flakey (got illegal ioctl when
trying to mount a loopback device)

I'd appreciate it if you copied me on any responses, as I currently am not
subscribed to the kernel mailing list, (because I don't have POP/SMTP access
at work.  (M.S. Exchange house and all....)

Sincerely

Steve Brueggeman
Software Engineer
XIOtech
