Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTLXSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTLXSs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 13:48:28 -0500
Received: from [195.62.234.69] ([195.62.234.69]:49865 "EHLO
	mail.nectarine.info") by vger.kernel.org with ESMTP id S263792AbTLXSs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 13:48:27 -0500
Message-ID: <3FE9DFA2.5070203@nectarine.info>
Date: Wed, 24 Dec 2003 19:49:06 +0100
From: Giacomo Di Ciocco <admin@nectarine.info>
Organization: Nectarine Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 "Losing too many ticks!" 
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
today i found a problem when upgrading the kernel of this box from 2.2.20 to
2.6.0, i tried to enable/disable ACPI support in the bios and in the kernel but
nothing was resolved.

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 797.317
cache size      : 64 KB

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY



Dec 24 16:36:31 xmas kernel: Losing too many ticks!
Dec 24 16:36:31 xmas kernel: TSC cannot be used as a timesource. (Are you
running with SpeedStep?)
Dec 24 16:36:31 xmas kernel: Falling back to a sane timesource.


Contact me for more informations. (or tell me to post it here)

Regards.

-- 
Giacomo Di Ciocco
Nectarine Administrator
Phone/Fax: 0577663107
Web: http://www.nectarine.info
Irc: irc.nectarine.info #nectarine
Email: admin@nectarine.info (pgp.mit.edu)
