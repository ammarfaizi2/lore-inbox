Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265136AbRF0RmC>; Wed, 27 Jun 2001 13:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbRF0Rlw>; Wed, 27 Jun 2001 13:41:52 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:6878 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S265136AbRF0Rle>; Wed, 27 Jun 2001 13:41:34 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880ACE@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: (reposting) how to get DMA'able memory within 4GB on 64-bit machi
	ne
Date: Wed, 27 Jun 2001 11:41:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this sometime back but I guess probably it got lost.

Is there a way for a driver to ask kernel to
give DMA'able memory within 4GB ? I read about
pci_alloc_consistent(). But I could not find out
whether that guarantees the DMA'able memory to be
within 4GB or not. Is there any other kernel routine
that I should call from Driver to get such a memory ?

Regards,
-hiren
hiren_mehta@agilent.com

