Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQKXRYw>; Fri, 24 Nov 2000 12:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129436AbQKXRYn>; Fri, 24 Nov 2000 12:24:43 -0500
Received: from waste.org ([209.173.204.2]:13118 "EHLO waste.org")
        by vger.kernel.org with ESMTP id <S129428AbQKXRYj>;
        Fri, 24 Nov 2000 12:24:39 -0500
Date: Fri, 24 Nov 2000 10:54:26 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Tigran Aivazian <tigran@veritas.com>
cc: Jes Sorensen <jes@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: deadlock on 4way machine
In-Reply-To: <Pine.LNX.4.21.0011212029260.1540-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.10.10011241047570.9367-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Tigran Aivazian wrote:

> On 21 Nov 2000, Jes Sorensen wrote:
> 
> > >>>>> "Tigran" == Tigran Aivazian <tigran@veritas.com> writes:
> > 
> > Tigran> Hi, Some processes get stuck in page fault handler for ages
> > Tigran> (like for 10 minutes!). The machine still has plenty (3.5G) of
> > Tigran> free high memory but zero (2216K) of free low memory.
> > 
> > Including info on the kernel version would kinda help.
> 
> that is obtainable by fingering @finger.kernel.org (I only ever use/report
> bugs on the latest kernel).

I think only Linus can claim that. At any rate, the world isn't going to
remember your particular preference for the latest kernel, nor is it going
to go to the trouble of trying to correlate the date on your messages with
a history of patch releases. If you report a bug thought to be fixed,
it'll just be assumed to be old.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
