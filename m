Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAXX7e>; Wed, 24 Jan 2001 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbRAXX7Y>; Wed, 24 Jan 2001 18:59:24 -0500
Received: from jalon.able.es ([212.97.163.2]:38615 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130336AbRAXX7Q>;
	Wed, 24 Jan 2001 18:59:16 -0500
Date: Thu, 25 Jan 2001 00:59:07 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pcmcia modules install path
Message-ID: <20010125005907.A5811@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Just a silly question. The pcmcia modules in 2.4.x get installed in
/lib/modules/`uname -r`/pcmcia, instead of
/lib/modules/`uname -r`/kernel/<whatever>

Is there any special reason for that or is just a harmelss buglet ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-pre10 #4 SMP Wed Jan 24 00:20:15 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
