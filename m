Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129744AbQK1Xub>; Tue, 28 Nov 2000 18:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130076AbQK1XuV>; Tue, 28 Nov 2000 18:50:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46097 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S130352AbQK1XuH>; Tue, 28 Nov 2000 18:50:07 -0500
Date: Wed, 29 Nov 2000 00:20:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: John Kennedy <jk@csuchico.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001129002009.I14675@athlon.random>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com> <20001125145701.A12719@athlon.random> <20001128150235.A7323@north.csuchico.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001128150235.A7323@north.csuchico.edu>; from jk@csuchico.edu on Tue, Nov 28, 2000 at 03:02:35PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 03:02:35PM -0800, John Kennedy wrote:
> On Sat, Nov 25, 2000 at 02:57:01PM +0100, Andrea Arcangeli wrote:
> > ... VM-global-*-7 has no known bugs AFIK.
> 
>   Is there anything more recent than VM-global-2.2.18pre18-7?  It isn't
> patching very cleanly against my pre-patch-2.2.18-23 tree. 

It patches cleanly for me. (ignore the offset warnings from patch, just make
sure there are no rejects)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
