Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTBMMwN>; Thu, 13 Feb 2003 07:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268030AbTBMMwN>; Thu, 13 Feb 2003 07:52:13 -0500
Received: from mail.siemenscom.com ([12.146.131.10]:28652 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP
	id <S267145AbTBMMwN>; Thu, 13 Feb 2003 07:52:13 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A125B1D@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: ARP Cache problem
Date: Thu, 13 Feb 2003 05:02:00 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an embedded system running a standard 2.4.18-3 Kernel. This system
has to send a message every 100ms via the default gateway to a partner
machine. There was a scenario where the system ARP'ed the gateway for its
address. The response was seen on the sniffer. The system however continued
to send ARP requests. A dump of the ARP cache showed it as incomplete. Any
ideas?

Please CC me directly on any responses.

Regards,

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

