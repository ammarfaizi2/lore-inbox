Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSCHH55>; Fri, 8 Mar 2002 02:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310716AbSCHH5i>; Fri, 8 Mar 2002 02:57:38 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:22276 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S293680AbSCHH5c>; Fri, 8 Mar 2002 02:57:32 -0500
Message-ID: <3C886DA3.7010408@megapathdsl.net>
Date: Thu, 07 Mar 2002 23:52:03 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: andreas.bombe@munich.netsurf.de
CC: linux-kernel@vger.kernel.org
Subject: 2.5.6 -- ieee1394drv.o: In function `initialize_dma_ir_prg': undefined reference to `virt_to_bus_not_defined_use_pci_map'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ieee1394/ieee1394drv.o: In function `initialize_dma_ir_prg':
drivers/ieee1394/ieee1394drv.o(.text+0xb1a2): undefined reference to 
`virt_to_bus_not_defined_use_pci_map'
drivers/ieee1394/ieee1394drv.o(.text+0xb1b5): undefined reference to 
`virt_to_bus_not_defined_use_pci_map'
drivers/ieee1394/ieee1394drv.o(.text+0xb22c): undefined reference to 
`virt_to_bus_not_defined_use_pci_map'
drivers/ieee1394/ieee1394drv.o(.text+0xb23f): undefined reference to 
`virt_to_bus_not_defined_use_pci_map'
drivers/ieee1394/ieee1394drv.o(.text+0xb2e8): undefined reference to 
`virt_to_bus_not_defined_use_pci_map'
drivers/ieee1394/ieee1394drv.o(.text+0xb2f9): more undefined references 
to `virt_to_bus_not_defined_use_pci_map' follow

CONFIG_IEEE1394=y
CONFIG_IEEE1394_PCILYNX=y
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_DV1394=y
CONFIG_IEEE1394_VERBOSEDEBUG=y

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.14
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11

