Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132580AbQKZT4F>; Sun, 26 Nov 2000 14:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132670AbQKZTzz>; Sun, 26 Nov 2000 14:55:55 -0500
Received: from [193.120.224.170] ([193.120.224.170]:29843 "EHLO
        florence.itg.ie") by vger.kernel.org with ESMTP id <S132580AbQKZTzr>;
        Sun, 26 Nov 2000 14:55:47 -0500
Date: Sun, 26 Nov 2000 19:25:44 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Phil Randal <phil@rebee.clara.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with hp C1537A tape drives
In-Reply-To: <3A2155FE.14692.110282@localhost>
Message-ID: <Pine.LNX.4.30.0011261900130.892-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Phil Randal wrote:

> Ah, have you tried cleaning the tape heads?
>

the drive gets a run of a cleaning tape on a weekly basis.

> far more frequently than you'd expect.  I've found it needs
> two cleaning tape passes to clear this one.
>

uhmmm.... ok. I've now done multiple cleanning runs with multiple
cleaning tapes. let's see what happens when i try the amflush.

> Cleaning solves a similar problem I get with these drives
> and Backup Exec for Netware.
>

and guess what... it's worked for me too. doh! guess once a week is
not enough then.

apologies to the list my tape cluelessness.

> Phil

thanks,

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
