Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129532AbQK1XdH>; Tue, 28 Nov 2000 18:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129818AbQK1Xc5>; Tue, 28 Nov 2000 18:32:57 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:9480 "EHLO
        north.net.csuchico.edu") by vger.kernel.org with ESMTP
        id <S129532AbQK1Xck>; Tue, 28 Nov 2000 18:32:40 -0500
Date: Tue, 28 Nov 2000 15:02:35 -0800
From: John Kennedy <jk@csuchico.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001128150235.A7323@north.csuchico.edu>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com> <20001125145701.A12719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001125145701.A12719@athlon.random>; from andrea@suse.de on Sat, Nov 25, 2000 at 02:57:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 02:57:01PM +0100, Andrea Arcangeli wrote:
> ... VM-global-*-7 has no known bugs AFIK.

  Is there anything more recent than VM-global-2.2.18pre18-7?  It isn't
patching very cleanly against my pre-patch-2.2.18-23 tree. 

  (I don't see anything under your pre19 thru pre23 dirs, but I
   may not be looking at a fully populated server or something.)

  Reiserfs on top of 2.2.18-23 blatantly runs me out of memory, and ext3fs
may be doing it too, although the laptop fan makes it sounds like it is
busy-looping somewhere.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
