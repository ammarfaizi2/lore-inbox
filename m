Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK2BGt>; Tue, 28 Nov 2000 20:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129937AbQK2BGj>; Tue, 28 Nov 2000 20:06:39 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:34824 "EHLO
        north.net.csuchico.edu") by vger.kernel.org with ESMTP
        id <S129183AbQK2BGZ>; Tue, 28 Nov 2000 20:06:25 -0500
Date: Tue, 28 Nov 2000 16:35:32 -0800
From: John Kennedy <jk@csuchico.edu>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001128163532.F7323@north.csuchico.edu>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com> <20001125145701.A12719@athlon.random> <20001128150235.A7323@north.csuchico.edu> <20001129002009.I14675@athlon.random> <20001128153615.E7323@north.csuchico.edu> <20001129010416.J14675@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001129010416.J14675@athlon.random>; from andrea@suse.de on Wed, Nov 29, 2000 at 01:04:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 01:04:16AM +0100, Andrea Arcangeli wrote:
> On Tue, Nov 28, 2000 at 03:36:15PM -0800, John Kennedy wrote:
> >   No, it is all ext3fs stuff that is touching the same areas your
> 
> Ok this now makes sense. I ported VM-global-7 on top of ext3 right now
> but it's untested:

  Not for long.  (:

>  ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7-against-ext3-0.0.3b-1.bz2

  Is ext3-0.0.3b the most current/stable?  On the FTP site (well,
ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs at least) it looks like
ext3-0.0.2f is current (which is what I've been using), but under the
test directory I see ext3-0.0.3b as well as ext3-0.0.5b.  I haven't
heard anything new about ext3fs in a long, long time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
