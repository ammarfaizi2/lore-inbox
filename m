Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156822-6448>; Wed, 12 May 1999 17:28:36 -0400
Received: by vger.rutgers.edu id <156421-17480>; Wed, 12 May 1999 13:06:59 -0400
Received: from mgelinas.ne.mediaone.net ([24.128.237.24]:26653 "EHLO mr-gateway.internal.net" ident: "root") by vger.rutgers.edu with ESMTP id <157497-17483>; Wed, 12 May 1999 08:51:45 -0400
Message-Id: <199905121338.JAA12587@mr-gateway.internal.net>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.rutgers.edu
Subject: In kernel process checkpointing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 May 1999 09:38:16 -0400
From: "J. Maynard Gelinas" <maynard@jmg.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   Kernel guru's,
   Can someone give an official word regarding kernel process checkpointing
support?  "Eduardo Pinheiro" <edpin@cos.ufrj.br> has a checkpoint patch,
EPCKPT(*), available against 2.2.1 and 2.0.36 with which "Werner G. Krebs"
<werner.krebs@yale.edu> is using for checkpoint and process migration
support in the development version of GNU/QUEUE(**).  This feature is of
interest to my employer and we're wondering if it, or something like it,
will wind up supported in the kernel proper. 

Thanks!
J. Maynard Gelinas 

(*)http://www.cos.ufrj.br/~edpin/epckpt/
(**)http://bioinfo.mbb.yale.edu/~wkrebs/queue.html


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
