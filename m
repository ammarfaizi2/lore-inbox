Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRASPSU>; Fri, 19 Jan 2001 10:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132347AbRASPSL>; Fri, 19 Jan 2001 10:18:11 -0500
Received: from jalon.able.es ([212.97.163.2]:29324 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131629AbRASPR4>;
	Fri, 19 Jan 2001 10:17:56 -0500
Date: Fri, 19 Jan 2001 16:17:38 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: TLB IPI error
Message-ID: <20010119161738.A4948@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying new updated nVidia drivers with AGPGART, I get:

Jan 19 15:44:39 werewolf kernel: stuck on TLB IPI wait (CPU#0)
(..or CPU#1, sometimes one or other...)

What does that mean ? Hard or soft error or some kernel feature that
is badly supported-malfunctions in my mobo ?
Mobo: i440GX, PIIX4, AGPx2, IO-APIC, 2xPII@400

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac9 #2 SMP Sun Jan 14 01:46:07 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
