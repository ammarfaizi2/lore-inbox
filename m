Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129070AbRAaXoM>; Wed, 31 Jan 2001 18:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129301AbRAaXoC>; Wed, 31 Jan 2001 18:44:02 -0500
Received: from jalon.able.es ([212.97.163.2]:52614 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129248AbRAaXnp>;
	Wed, 31 Jan 2001 18:43:45 -0500
Date: Thu, 1 Feb 2001 00:43:35 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: gcc freeze for 3.0 ?
Message-ID: <20010201004335.A17944@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I did not misunderstood this news (Jan 15):

http://gcc.gnu.org/gcc-3.0/branch.html
http://gcc.gnu.org/ml/gcc/2001-01/msg00871.html

the gcc tree is feature-freezed to prepare 3.0. No more optimization
algorithms, no more syntax-feature changes. Only bug fixes and
compilation speed improvements.

So this is the gcc to feed kernel to, and check it for 3.0 release...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-zcn #1 SMP Tue Jan 30 11:38:19 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
