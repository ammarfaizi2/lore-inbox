Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131139AbQK2Lrf>; Wed, 29 Nov 2000 06:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130587AbQK2LrZ>; Wed, 29 Nov 2000 06:47:25 -0500
Received: from hera.cwi.nl ([192.16.191.1]:40919 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131143AbQK2LrN>;
        Wed, 29 Nov 2000 06:47:13 -0500
Date: Wed, 29 Nov 2000 12:16:43 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011291116.MAA147726.aeb@aak.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: corruption
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can you give a rough estimate on when you suspect you started seeing it?

I reported both cases. That is, I started seeing it a few days ago.
(But there is no problem during daily work. Also for example a
diff between two kernel trees never gave corruption so far.
It was only with diff between trees several GB in size, and I
don't do that very often.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
