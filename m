Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBFPCB>; Tue, 6 Feb 2001 10:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRBFPBw>; Tue, 6 Feb 2001 10:01:52 -0500
Received: from jalon.able.es ([212.97.163.2]:62608 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129030AbRBFPBi>;
	Tue, 6 Feb 2001 10:01:38 -0500
Date: Tue, 6 Feb 2001 16:01:10 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: /dev/shm mount visible
Message-ID: <20010206160110.A4163@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a little question. In previous kernels and shm patches the /dev/shm
filesytem was invisible under a 'mount' query (just managed like procfs
or devpts). Now it appears listed under a mount command. Is it normal ?
Does mount show it coz it is no more 'special' or hidden in any way ?

(now i'm running 2.4.1-ac3)
 
-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac3 #1 SMP Tue Feb 6 01:06:05 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
