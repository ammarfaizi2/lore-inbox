Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQKYXH0>; Sat, 25 Nov 2000 18:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129257AbQKYXHQ>; Sat, 25 Nov 2000 18:07:16 -0500
Received: from mail1.rdc3.on.home.com ([24.2.9.40]:52113 "EHLO
        mail1.rdc3.on.home.com") by vger.kernel.org with ESMTP
        id <S129183AbQKYXHF>; Sat, 25 Nov 2000 18:07:05 -0500
Message-ID: <3A203F0A.29336B56@home.com>
Date: Sat, 25 Nov 2000 17:36:58 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11ac4
In-Reply-To: <E13zmwU-0001MJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> o       Fix ppa and imm hangs on io_request_lock        (Tim Waugh)

Just so I understand the differences, for learning purposes... Tim did
this a little different than I did and I'd just like to understand the
"whys" of it. 

Can't learn if I don't understand. :o)

Thanks,
John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
