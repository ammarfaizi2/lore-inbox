Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132436AbQK3A7T>; Wed, 29 Nov 2000 19:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132465AbQK3A7J>; Wed, 29 Nov 2000 19:59:09 -0500
Received: from hera.cwi.nl ([192.16.191.1]:50359 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S132436AbQK3A6x>;
        Wed, 29 Nov 2000 19:58:53 -0500
Date: Thu, 30 Nov 2000 01:28:13 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011300028.BAA150956.aeb@aak.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, rusty@rustcorp.com.au, torvalds@transmeta.com
Subject: another problem disappeared
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I muttered a bit about the fact that
with 2.4.0test11 masquerading, the first packet
that was to be forwarded crashes the kernel. Always.
Tonight I wanted to start investigating this more closely,
but to my pleasant surprise 2.4.0test12pre3 does not have
this problem. Progress.

(I am still a bit curious: did other people see this?
Did someone fix a known problem with net(filter) or say /proc?
It would be a pity if this disappeared by coincidence
and appears again next month.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
