Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132292AbQK3ATK>; Wed, 29 Nov 2000 19:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132306AbQK3ATA>; Wed, 29 Nov 2000 19:19:00 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:18706 "EHLO
        smtp.lax.megapath.net") by vger.kernel.org with ESMTP
        id <S132292AbQK3ASo>; Wed, 29 Nov 2000 19:18:44 -0500
Message-ID: <3A259548.1090000@megapathdsl.net>
Date: Wed, 29 Nov 2000 15:46:16 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Haines <rick@kuroyi.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: test12-pre3 (broke my usb)
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com> <20001129183834.A443@sasami.kuroyi.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Haines wrote:

> On Tue, Nov 28, 2000 at 10:57:35PM -0800, Linus Torvalds wrote:
> 
>>  - pre3:
>>     - Johannes Erdfelt: USB update
> 
> 
> Seems to have broken my IntelliMouse Optical (logs from the third time
> I inserted usb-uhci):

Yes.  This problem has been reported by two others on the
Linux USB Development list.  It is being explored.

If you'd like to contribute to testing whatever patches get
offered to fix this bug, you could send a note saying so to
linux-usb-devel@sourceforge.net.  If you want to stay in the
loop on USB development, you might also want to join the
Linux-USB-Users list.  You can join by filling out the form here:

http://lists.sourceforge.net/mailman/listinfo/linux-usb-users

Best wishes and thanks for the bug report!

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
