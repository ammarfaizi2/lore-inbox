Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131315AbQKYRxb>; Sat, 25 Nov 2000 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131466AbQKYRxW>; Sat, 25 Nov 2000 12:53:22 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:8946 "HELO
        matrix.mandrakesoft.com") by vger.kernel.org with SMTP
        id <S131315AbQKYRxE>; Sat, 25 Nov 2000 12:53:04 -0500
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.2.18-23 as pppd dial in server
In-Reply-To: <3A1EF9A5.2E335F0C@timpanogas.org>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 25 Nov 2000 18:22:57 +0100
In-Reply-To: <3A1EF9A5.2E335F0C@timpanogas.org>
Message-ID: <m37l5s2cge.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@timpanogas.org> writes:

> Was able to reproduce this Oops, but it took several days.   Oops occurs
> against 2.2.18-23.  I had to copy this info from the console -- the
> system was hard hung after the oops and even ksymoops was locked solid.

what type of mounted filesystem you have (dos/ext2) ?

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
