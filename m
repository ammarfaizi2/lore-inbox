Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbQKRAro>; Fri, 17 Nov 2000 19:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbQKRAre>; Fri, 17 Nov 2000 19:47:34 -0500
Received: from hera.cwi.nl ([192.16.191.1]:31440 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130335AbQKRArV>;
	Fri, 17 Nov 2000 19:47:21 -0500
Date: Sat, 18 Nov 2000 01:17:15 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011180017.BAA126953.aeb@aak.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Cc: aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, koenig@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I take it you'll also do the third part?

> Are you talking about isofs_lookup_grandparent()?

No, about isofs_read_inode.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
