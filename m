Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSAYWe1>; Fri, 25 Jan 2002 17:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288432AbSAYWeR>; Fri, 25 Jan 2002 17:34:17 -0500
Received: from smtp1.libero.it ([193.70.192.51]:29857 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S288051AbSAYWeK>;
	Fri, 25 Jan 2002 17:34:10 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Fri, 25 Jan 2002 23:32:43 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <20020125133814.U763@lynx.adilger.int> <20020125231555.A22583@wotan.suse.de>
In-Reply-To: <20020125231555.A22583@wotan.suse.de>
Subject: eth0: NULL pointer encountered in RX ring, skipping
MIME-Version: 1.0
Message-Id: <0201252332430B.01074@af>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After such kernel message the network interface (kernel 2.4.2) replied to 
ping from other network's machines with times varying between 200 and 2000 ms
and it was almost impossible to use the network to transferring files to or 
from this PC.
The card is a SIS960 on the mboard on an Acer PC with a Celeron 666 Mhz 
processor.

The problem was solved with a shutdown -h, powering down and powering up
the PC.

Can somebody explain the trouble?

Best regards to all all and thx to replying people,

Andrea
