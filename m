Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133044AbRD0Jur>; Fri, 27 Apr 2001 05:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRD0Juh>; Fri, 27 Apr 2001 05:50:37 -0400
Received: from smtprelay.gecm.com ([62.172.222.133]:57863 "EHLO
	smtprelay.gecm.com") by vger.kernel.org with ESMTP
	id <S133044AbRD0Ju3>; Fri, 27 Apr 2001 05:50:29 -0400
Date: Fri, 27 Apr 2001 10:52:20 +0100
From: dave.fraser@baesystems.com
Subject: Resetting a PCI device
To: linux-kernel@vger.kernel.org
Message-id: <001901c0ceff$c0ae88e0$64ccdd89@edinbr.gmav.gecm.com>
Organization: BAE Systems
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way of issuing a PCI reset (safely) without rebooting?  I am
developing a peripheral device (using a pci card with an FPGA and a plx9080
pci interface), and find that its local bus is prone to hanging up.  It
would be nice if I could just reset the entire device via the PCI reset,
without having to go through the hassle of a reboot.  Is this wishful
thinking?

- Dave

---------------------------------------------------------------------
 Dave Fraser
 Development Engineer
 BAE Systems, Ferry Road,
 Edinburgh, EH5 2XS
 Tel: +44 131 3434729
 Fax: +44 131 3434124
---------------------------------------------------------------------

