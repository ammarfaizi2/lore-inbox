Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCXBg>; Fri, 3 Nov 2000 18:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129034AbQKCXB1>; Fri, 3 Nov 2000 18:01:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1703 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129033AbQKCXBJ>;
	Fri, 3 Nov 2000 18:01:09 -0500
Date: Fri, 3 Nov 2000 14:46:18 -0800
Message-Id: <200011032246.OAA12904@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: sunol_handa@non.agilent.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971A3D976@xsj02.sjs.agilent.com>
	(sunol_handa@non.agilent.com)
Subject: Re: linux support for TCP/IP Task Offload ....
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971A3D976@xsj02.sjs.agilent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: sunol_handa@non.agilent.com
   Date: 	Fri, 3 Nov 2000 15:50:48 -0700 

   Does Linux have any TCP/IP Task Offload support ?

   If a network adapter can offload some of the TCP/IP tasks, is there
   a support from Linux for such activity ?

Work for this is in progress.  Patches can be found at:

ftp://ftp.inr.ac.ru/ip-routing/zerocopy-sendfile-*.dif
ftp://ftp.inr.ac.ru/ip-routing/README.zerocopy-sendfile

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
