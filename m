Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rDLyR156436>; Sat, 15 May 1999 10:07:25 -0400
Received: by vger.rutgers.edu id <S.rDFCd154892>; Sat, 15 May 1999 02:26:49 -0400
Received: from mgelinas.ne.mediaone.net ([24.128.237.24]:29303 "EHLO mr-gateway.internal.net") by vger.rutgers.edu with ESMTP id <S.rD8bC160959>; Fri, 14 May 1999 18:55:10 -0400
Message-Id: <199905142345.TAA17348@mr-gateway.internal.net>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.rutgers.edu
Subject: In kernel userspace process checkpoint support?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 May 1999 19:45:55 -0400
From: "J. Maynard Gelinas" <maynard@jmg.com>
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926777237.221314.27315

   Folks,
   I sent this mail out on Wednesday and no one answered. (3)  There's been
a bunch of stuff going on, what with 2.3.0 and 2.2.[89] released so
recently... I figure my question just got lost in the noise.  So here goes
again:

---------------------------------------------------------------------

   Can someone give an official word regarding kernel process checkpointing
support?  "Eduardo Pinheiro" <edpin@cos.ufrj.br> has a checkpoint patch,
EPCKPT(1), available against 2.2.1 and 2.0.36 with which "Werner G. Krebs"
<werner.krebs@yale.edu> is using for checkpoint and process migration
support in the development version of GNU/QUEUE(2).  This feature is of
interest to my employer and we're wondering if it, or something like it,
will wind up supported in the kernel proper. (4)

Thanks!
J. Maynard Gelinas 

(1)http://www.cos.ufrj.br/~edpin/epckpt/
(2)http://bioinfo.mbb.yale.edu/~wkrebs/queue.html

---------------------------------------------------------------------

(3) http://www.linuxhq.com/lnxlists/linux-kernel/lk_9905_02/msg00671.html
(4) Personally, I think it would be a cool feature -- but that's JMHO.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
