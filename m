Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270519AbRHNI3U>; Tue, 14 Aug 2001 04:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270524AbRHNI3K>; Tue, 14 Aug 2001 04:29:10 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:58630 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S270519AbRHNI3B>; Tue, 14 Aug 2001 04:29:01 -0400
To: linux-kernel@vger.kernel.org
Subject: problem with PCMCIA and kernel 2.4.x
Message-ID: <997777753.3b78e159b004c@imp.free.fr>
Date: Tue, 14 Aug 2001 10:29:13 +0200 (MEST)
From: benjilr@free.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.42
X-Originating-IP: 172.190.136.142
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a problem Because when the PCMCIA start, I've the message :
PCI : NO IRQ known for interrupt pin A of device 01:02.0 please try
using pci=bios, but when this parametre, IRQ is always unknow.

But when kernel Start, I've this message : 
PCI : Probing PCI hardware
Unknow bridge ressource 2: assuming transparent
PCI : Using IRQ router PIIX [8086/244c] at 00:1f.0

Thank in advance for help.

PS:I've a laptop sony PCG-FX203
   PCMCIA work with kernel 2.2.19, but with this kernel there's no
usb-storage (for usb zip) support

Benjamin
