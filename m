Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291170AbSAaRYf>; Thu, 31 Jan 2002 12:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291169AbSAaRYc>; Thu, 31 Jan 2002 12:24:32 -0500
Received: from [203.167.246.143] ([203.167.246.143]:63456 "EHLO
	mediasolutions.net.nz") by vger.kernel.org with ESMTP
	id <S291168AbSAaRXW>; Thu, 31 Jan 2002 12:23:22 -0500
From: "Carl Bowden" <carl@e2-media.co.nz>
Subject: dl2k HostError
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4.7
Date: Fri, 01 Feb 2002 06:02:15 +1300
Message-ID: <web-1721666@mediasolutions.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

we have 2 nearly identical servers each with the D-Link
DGE-550T Adapter, one has no problems, the other constantly
reports the error below:

D-Link DL2000-based linux driver v1.08 2002/01/17
eth2: D-Link DGE-550T Gigabit Ethernet Adapter,
00:05:5d:f9:2b:8a, IRQ 9
Auto 1000 Mbps, Full duplex
Enable Tx Flow Control
Enable Rx Flow Control
eth2: HostError! IntStatus 0002.


we have tried  the driver at 100Mbps half & full duplex,
with & without Flow controls
and we have also tried the 1.04 (2.4.17) and the RH 7.2
stock kernel (its "PCI Error! IntStatus 0002" with the older
drivers)

we have several other card in the machine, such as an
Adaptec 2100A raid 5 card and a 3c980 Nic, these are fine

to be honest Im not sure if this is a pci bus problem or a
driver one.

is there any other information that would help?

any commentsor pointers  would be a great help

TIA

Cheers carl

carl@e2-media.co.nz

