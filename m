Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130420AbQK1DTe>; Mon, 27 Nov 2000 22:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130540AbQK1DTY>; Mon, 27 Nov 2000 22:19:24 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:23286 "EHLO
        shell.webmaster.com") by vger.kernel.org with ESMTP
        id <S130420AbQK1DTK>; Mon, 27 Nov 2000 22:19:10 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <joeja@mindspring.com>, <linux-kernel@vger.kernel.org>
Subject: RE: out of swap
Date: Mon, 27 Nov 2000 18:49:08 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKEJAMCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20001128020501.27708.qmail@web512.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Last night I was browsing the web and I came across a page with
> LOTS of images.  There were so many that it drove my swap space
> to ZERO.  I still had 3 Meg of memory, but the system became
> virtually unusable and SLOW. (there were over 150 x 30k+ images
> on one page).
>
> Is this something that the OOM would fix or is this another
> issue altogether?
>
> The machine has
> 64Meg of swap space, 128 Meg of RAM, Dual 233MMX, Itis running
> 2.2.17 and Rh 6.2.
>
> Any ideas?  thanks Joe

	Add more swap. What would you like the system to do if it's out of both
memory and swap? It can either kill processes or become slow.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
