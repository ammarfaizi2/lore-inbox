Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRCTQRA>; Tue, 20 Mar 2001 11:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbRCTQQu>; Tue, 20 Mar 2001 11:16:50 -0500
Received: from thorgal.et.tudelft.nl ([130.161.40.91]:16986 "EHLO
	thorgal.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130466AbRCTQQi>; Tue, 20 Mar 2001 11:16:38 -0500
Mime-Version: 1.0
Message-Id: <a05010400b6dd30073ea8@[130.161.115.44]>
Date: Tue, 20 Mar 2001 17:15:40 +0100
To: linux-kernel@vger.kernel.org
From: "J.D. Bakker" <bakker@thorgal.et.tudelft.nl>
Subject: Developing Linux-compatible Ethernet hardware
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need a Fast Ethernet chip for an Open Hardware PCI board I'm 
working on. Of course said chip has to be available in small 
quantities (and not just attached to a NIC), and well supported by 
Linux. Other 'nice but not crucial' properties would be:

- Gigabit Ethernet support
- Integrated PHY
- 66MHz PCI compliant
- Multiple ports

As it stands I'm thinking about using the Intel 82559ER (which lacks 
Gig Enet and 66MHz PCI), but I'm *very* open to other suggestions.

Thanks,

JD 'linux-hardware-dev@vger anyone ?' B.
[oh, and the board will have 4-way SMP with G4 PowerPCs]
-- 
LART. 250 MIPS under one Watt. Free hardware design files.
http://www.lart.tudelft.nl/
