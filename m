Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTLLNIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTLLNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:08:53 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:62665 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S264565AbTLLNIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:08:52 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.0-test11: 3Com PCI 3c556B not working
Date: Fri, 12 Dec 2003 13:08:51 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121308.51306.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another problem with 2.6 on my thinkpad. Worked fine with 2.4

Dmesg gives

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1400. Vers LK1.1.19
PCI: Setting latency timer of device 0000:00:03.0 to 64
  ***WARNING*** No MII transceivers found!

I've got ACPI enabled; Might this be ACPI/interrupt  related?

Andrew Walrond

