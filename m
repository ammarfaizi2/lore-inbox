Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129842AbQK1Qr2>; Tue, 28 Nov 2000 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129800AbQK1QrU>; Tue, 28 Nov 2000 11:47:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13444 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S129842AbQK1QrC>;
        Tue, 28 Nov 2000 11:47:02 -0500
Date: Tue, 28 Nov 2000 08:01:45 -0800
Message-Id: <200011281601.IAA02663@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tigran@veritas.com
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011281608460.1254-100000@penguin.homenet>
        (message from Tigran Aivazian on Tue, 28 Nov 2000 16:09:17 +0000
        (GMT))
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.4.21.0011281608460.1254-100000@penguin.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please just finally tell us what you are trying to do with
all this instead of just pointing out side-effect details.

What are you trying to do that requires counting the number
of open files?

It all smells very fishy, as Alexander stated.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
