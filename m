Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129659AbQKZGxR>; Sun, 26 Nov 2000 01:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129789AbQKZGxH>; Sun, 26 Nov 2000 01:53:07 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26635 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129659AbQKZGwr>;
        Sun, 26 Nov 2000 01:52:47 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" 
In-Reply-To: Your message of "Sat, 25 Nov 2000 21:10:19 -0800."
             <Pine.LNX.4.10.10011252106330.10651-100000@master.linux-ide.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Nov 2000 17:22:34 +1100
Message-ID: <11480.975219754@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000 21:10:19 -0800 (PST), 
Andre Hedrick <andre@linux-ide.org> wrote:
>On Sun, 26 Nov 2000, John Alvord wrote:
>> It also says "I do not know much about the details of the kernel C
>> environment. In particular I do not know that all static variables are
>> initialized to 0 in the kernel startup. I have not read setup.S."
>
>Are you positive for modules too...

Yes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
