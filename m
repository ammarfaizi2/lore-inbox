Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131121AbQKXOTa>; Fri, 24 Nov 2000 09:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131242AbQKXOTR>; Fri, 24 Nov 2000 09:19:17 -0500
Received: from hera.cwi.nl ([192.16.191.1]:54666 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129784AbQKXNS0>;
        Fri, 24 Nov 2000 08:18:26 -0500
Date: Fri, 24 Nov 2000 13:48:14 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011241248.NAA138093.aeb@aak.cwi.nl>
To: jakub@redhat.com
Subject: Re: gcc-2.95.2-51 is buggy
Cc: alan@lxorguk.ukuu.org.uk, bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so the reason why it did not show up in the gcc you picked up from
> ftp.gnu.org is that you have compiled it so that it defaults to -mcpu=i686

Yes, you are right.

So 2.95.2 fails for i386, i486, i586 and does not fail for i686.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
