Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbQKAWlY>; Wed, 1 Nov 2000 17:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131751AbQKAWlO>; Wed, 1 Nov 2000 17:41:14 -0500
Received: from jalon.able.es ([212.97.163.2]:38318 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131708AbQKAWlG>;
	Wed, 1 Nov 2000 17:41:06 -0500
Date: Wed, 1 Nov 2000 23:40:58 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001101234058.B1598@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that in latest patch for 2.4.0, the global Makefile
no more tries to find a kgcc, and falls back to gcc.
I suppose because 2.7.2.3 is no more good for kernel, but still you
can use 2.91, 2.95.2 or 2.96(??). Is that a patch that leaked in
the way to test10, or is for another reason ?.

TIA

-- 
Juan Antonio Magallon Lacarta                          mailto:jamagallon@able.es

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
