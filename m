Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131249AbRAZX1R>; Fri, 26 Jan 2001 18:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131253AbRAZX1H>; Fri, 26 Jan 2001 18:27:07 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:17671 "HELO
	zmamail04.zma.compaq.com") by vger.kernel.org with SMTP
	id <S131249AbRAZX06>; Fri, 26 Jan 2001 18:26:58 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D3116FC1@cceexc19.americas.cpqcorp.net>
From: "Zink, Dan" <Dan.Zink@COMPAQ.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        linux-hotplug-devel@lists.sourceforge.net
Cc: LinuxHotplug <LinuxHotplug@COMPAQ.com>
Subject: [ANNOUNCE] PCI Hot Plug driver and 2.4.0 kernel patches available
Date: Fri, 26 Jan 2001 17:30:01 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compaq would like to announce the availability of the Linux PCI Hot Plug
driver for the Compaq PCI Hot Plug controller.  This driver is being
released under the GPL.  It supports hot plug add and remove of nearly any
PCI adapter in servers with the Compaq PCI Hot Plug controller.  For best
results, the adapter drivers should support the new probe and remove hooks
registered with pci_module_init().

The driver, minor kernel patches, userspace tools, and documentation are all
available at Compaq's sourceforge site:
http://opensource.compaq.com

This is a fully functional alpha release.  Please send all comments and CC
replies to mailto://linuxhotplug@compaq.com

If you wish to see a demonstration of PCI Hot Plug on Linux or just talk
about it, we will be at LinuxWorld in New York City next week.  Stop by the
Compaq booth and look for us.

Thanks,
Dan Zink
____________________________
dan.zink@compaq.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
