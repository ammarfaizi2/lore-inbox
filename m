Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966690AbWKOIws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966690AbWKOIws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966705AbWKOIws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:52:48 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:33419 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S966704AbWKOIwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:52:47 -0500
Subject: DELL Latitude D810 asks for pci=assign-busses
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: iNES Group
Date: Wed, 15 Nov 2006 10:52:45 +0200
Message-Id: <1163580765.2879.8.camel@DustPuppy.LNX.RO>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

The kernel (2.6.18.1-something) asked me to report this  :)

"PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently"

I've attached the dmesg and lspci with and without pci=assign-busses.
Also for future reference I opened #7528 .
http://bugme.osdl.org/show_bug.cgi?id=7528

Please let me know if you need more data.

Thank you for the great work,

-- 
Cioby


