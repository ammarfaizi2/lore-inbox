Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130303AbRBAVfE>; Thu, 1 Feb 2001 16:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRBAVey>; Thu, 1 Feb 2001 16:34:54 -0500
Received: from sense-gold-134.oz.net ([216.39.162.134]:2564 "EHLO
	sense-gold-134.oz.net") by vger.kernel.org with ESMTP
	id <S129082AbRBAVen>; Thu, 1 Feb 2001 16:34:43 -0500
Date: Thu, 1 Feb 2001 13:34:43 -0800
From: al goldstein <gold@sense-gold-134.oz.net>
Message-Id: <200102012134.NAA00915@sense-gold-134.oz.net>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: no networking

Moving from 2.2.16 to 2.4.1. I'm running Mandrake 7.0 SMP on an Abit
board. There are 2 ether interfaces using 3com 3c59x and 3c509, and the kernel
is configured as a router. Updates were made following recommendations in 
"Changes". Kernel built OK. Netstat -rn and ipconfig -a are unchanged but
no packets are released from the interfaces. Any hints would be appreciated.

......Al Goldstein

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
