Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129722AbQKZLLi>; Sun, 26 Nov 2000 06:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130874AbQKZLL2>; Sun, 26 Nov 2000 06:11:28 -0500
Received: from 194-73-188-238.btconnect.com ([194.73.188.238]:30724 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129722AbQKZLLP>;
        Sun, 26 Nov 2000 06:11:15 -0500
Date: Sun, 26 Nov 2000 10:43:08 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: John Alvord <jalvo@mbay.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <3a219890.57346310@mail.mbay.net>
Message-ID: <Pine.LNX.4.21.0011261039120.1015-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, John Alvord wrote:
> It also says "I do not know much about the details of the kernel C
> environment. In particular I do not know that all static variables are
> initialized to 0 in the kernel startup. I have not read setup.S."

John, please stop insulting Andries, you would be _surprized_ to find out
how much he actually knows about a multitude of things.

As for Andries' point of loss of information, he has a point, _but_ James'
suggestion to put that extra info in the comment, imho, outweighs the
small disadvantages (code looks a bit uglier) which Andries pointed out to
counter it.

Regards,
Tigran.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
