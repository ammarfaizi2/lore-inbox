Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbQKBCnG>; Wed, 1 Nov 2000 21:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbQKBCm4>; Wed, 1 Nov 2000 21:42:56 -0500
Received: from p3EE0A7CB.dip.t-dialin.net ([62.224.167.203]:31221 "EHLO
	cerebro") by vger.kernel.org with ESMTP id <S129181AbQKBCmn>;
	Wed, 1 Nov 2000 21:42:43 -0500
Date: Thu, 2 Nov 2000 03:42:33 +0100
From: Marc Lehmann <pcg@goof.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001102034232.C10806@cerebro.laendle>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <20001101163752.B2616@fsmlabs.com> <200011012329.PAA19890@pizda.ninka.net> <20001101165418.B3444@hq.fsmlabs.com> <200011012345.PAA20284@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011012345.PAA20284@pizda.ninka.net>; from davem@redhat.com on Wed, Nov 01, 2000 at 03:45:24PM -0800
X-Operating-System: Linux version 2.2.17 (root@cerebro) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 03:45:24PM -0800, "David S. Miller" <davem@redhat.com> wrote:
>    explain why RedHat includes a compiler that doesn't work with the
> 
> Because the kernel is buggy (the specifics of this has been discussed

But redhat's compiler is much, much buggier, as has been discussed here
as well. Actually, redhat's gcc branch fails to compile a large amount of
userspace applications that aren't buggy.

I thought redhat already agreed that they made a bad decision in many
regards and the real reason for having the compiler was mere policy of not
switching the compiler duing a major release, and rehdat wanted to have a
newer compiler in any case.

...

> they did XXX" I would expect you to defend your employer as well if I
> misrepresented them due to incorrect statements.  Right?  :-)

Sometimes one just keeps quiet, and that's o.k.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
