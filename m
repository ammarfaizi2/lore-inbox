Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKEWmu>; Sun, 5 Nov 2000 17:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbQKEWmk>; Sun, 5 Nov 2000 17:42:40 -0500
Received: from p3EE0A434.dip.t-dialin.net ([62.224.164.52]:6649 "EHLO cerebro")
	by vger.kernel.org with ESMTP id <S129121AbQKEWm2>;
	Sun, 5 Nov 2000 17:42:28 -0500
Date: Sun, 5 Nov 2000 23:42:25 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Cc: Tim Riker <Tim@Rikers.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
Message-ID: <20001105234225.J443@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org, Tim Riker <Tim@Rikers.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E13s11X-0004TQ-00@the-village.bc.nu> <3A05C888.7558E0F0@Rikers.org> <20001105160637.Z6207@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001105160637.Z6207@devserv.devel.redhat.com>; from jakub@redhat.com on Sun, Nov 05, 2000 at 04:06:37PM -0500
X-Operating-System: Linux version 2.2.17 (root@cerebro) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 04:06:37PM -0500, Jakub Jelinek <jakub@redhat.com> wrote:
> That's hard to do, because the whole gcc has copyright assigned to FSF,
> which means that either gcc steering committee would have to make an
> exception from this

Which can not and will not happen.

> for SGI, or SGI would have to be willing to assign some code to FSF.

Which is the standard procedure that the FSF requires for all it's
programs to be able to defend them - incorporating non-assigned code into
gcc creates some intractable problems (i.e.: make it impossible) when the
FSD ever wanted to go to court to defend the freedom of gcc.

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
