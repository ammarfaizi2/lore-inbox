Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbQLQACX>; Sat, 16 Dec 2000 19:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbQLQACO>; Sat, 16 Dec 2000 19:02:14 -0500
Received: from ccs.covici.com ([209.249.181.196]:7172 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S131080AbQLQAB6>;
	Sat, 16 Dec 2000 19:01:58 -0500
Date: Sat, 16 Dec 2000 18:31:28 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: 8139too problem in 2.2.18
Message-ID: <Pine.LNX.4.21.0012161828180.628-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have a RealTech 8139 Ethernet card and I am using kernel
2.2.18.  I tried to use the new driver 8139too as a module, but when
doing an insmod or modprobe on the module I got "symbol forparameter
debug not found".  There was nothing obvious in the module source, so
any assistance would be appreciated.



-- 
         John Covici
         covici@ccs.covici.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
