Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSGWOrU>; Tue, 23 Jul 2002 10:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318077AbSGWOrT>; Tue, 23 Jul 2002 10:47:19 -0400
Received: from firewall.webigen.com ([212.108.223.254]:32049 "EHLO
	mail.webigen.com") by vger.kernel.org with ESMTP id <S318076AbSGWOrT>;
	Tue, 23 Jul 2002 10:47:19 -0400
Subject: problems on crusoe-based laptop
From: Tibor Veres <infrared@webigen.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2002 16:50:09 +0200
Message-Id: <1027435810.26534.28.camel@infrared>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to install linux to a toshiba libretto l5 (transmeta crusoe
TM5800). 

I have no cd or floppy, I boot over the network with intel pxe bootrom..
DHCP works, after stripping down the kernel to <512k, the kernel loads
too, but I get the following error message: 

AX: 0205
BX: 0200
CX: 0020
DX: 0000.
8000

I tryed with the following configurations:
version: 2.4.18, 2.4.17
toshiba laptop support: on/off
pci access mode: direct/bios/both
cpu: 386/crusoe
everything else turned off except for IDE and ext2

What does the error message mean? What should I do to make it boot.


Please CC to my address too.




