Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129267AbQK2HPb>; Wed, 29 Nov 2000 02:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129348AbQK2HPU>; Wed, 29 Nov 2000 02:15:20 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:44555 "EHLO
        moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
        id <S129267AbQK2HPK>; Wed, 29 Nov 2000 02:15:10 -0500
Date: Tue, 28 Nov 2000 22:44:37 -0800
Message-Id: <200011290644.eAT6ibb26028@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A24881D.B2EBA35E@haque.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre23 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000 23:37:49 -0500, Mohammad A. Haque <mhaque@haque.net> wrote:
> Ok, I just found a file with about the first 4k of it filled with nulls
> (^@^@). No telling if this was a result of what originally started this
> thread or not. I hadn't accessed that file since Nov 9th.

1k- or 4k-block filesystem? Also, can you count the nulls to see if
they are exactly 4096 of them?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
