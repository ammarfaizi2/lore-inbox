Return-Path: <linux-kernel-owner+w=401wt.eu-S932498AbXAQQFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbXAQQFs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbXAQQFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:05:48 -0500
Received: from tur.go2.pl ([193.17.41.50]:59128 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932498AbXAQQFr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:05:47 -0500
Subject: =?UTF-8?Q?kernel=202.6.19.1=20-=20Please=20report=20the=20result?=
	=?UTF-8?Q?=20to=20linux-kernel=20to=20fix=20this=20permanently?=
From: =?UTF-8?Q? "taps" ?= <taps@go2.pl>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-ID: <4bedf1a2.66c6cf88.45ae491d.26f3c@o2.pl>
Date: Wed, 17 Jan 2007 17:04:45 +0100
X-Originator: 83.167.242.78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got this text when I boot my linux :

--cut--

PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
ACPI: PCI Interrupt Link [LNKB] (IRQs 11) *10

--cut--

Kernel 2.6.19.1 without any patch.
Debian 4.0 Etch.
Everything works on laptop Toshiba satellite pro L10
Do you need any more information ?

Regards
Grzegorz Spyra
