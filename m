Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVTR6>; Wed, 22 Nov 2000 14:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129765AbQKVTRt>; Wed, 22 Nov 2000 14:17:49 -0500
Received: from duracef.shout.net ([204.253.184.12]:17681 "EHLO
        duracef.shout.net") by vger.kernel.org with ESMTP
        id <S129730AbQKVTRo>; Wed, 22 Nov 2000 14:17:44 -0500
Date: Wed, 22 Nov 2000 12:48:30 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200011221848.MAA05565@duracef.shout.net>
To: jamagallon@able.es, peter@cadcamlab.org
Subject: Re: beware of dead string constants
Cc: jakub@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jakub Jelinek claims to have fixed this particular bug in the last week
> or so, although I have not downloaded and compiled recent CVS to verify
> this.

I have a compiler from gcc.gnu.org's CVS tree that's only a few days old,
so I can verify Jakub's claim.

It Works For Me (tm).

There is a considerable amount of engineering and testing and releasology
and distribution between "CVS compiler" and "production compiler for
kernel builds" though.

> and according to Jeff Law, this case is *not* fixed yet.

My compiler behaves as Jeff says.

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
