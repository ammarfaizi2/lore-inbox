Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133050AbRDUX26>; Sat, 21 Apr 2001 19:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133052AbRDUX2s>; Sat, 21 Apr 2001 19:28:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133050AbRDUX2g>; Sat, 21 Apr 2001 19:28:36 -0400
Subject: Re: Request for comment -- a better attribution system
To: esr@thyrsus.com
Date: Sun, 22 Apr 2001 00:29:22 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421164659.A4704@thyrsus.com> from "Eric S. Raymond" at Apr 21, 2001 04:46:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r6oh-0004Zu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another is to be able to generate reports on exactly how much of the kernel
> is in "Maintained" or "Supported" status.  I think it would be worth 
> making this change just so we could know that.

There is no correlation between claimed and actual levels of supportedness.
There are drivers with no-one supporting them that are common and thus get
fixed very rapidly for example.

I actually prefer MAINTAINERS because it breaks things down by area and reflects
the actual maintainership and areas covered. Something that per file does not

