Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbQKEVHF>; Sun, 5 Nov 2000 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129497AbQKEVG4>; Sun, 5 Nov 2000 16:06:56 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:8966 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129162AbQKEVGw>; Sun, 5 Nov 2000 16:06:52 -0500
Date: Sun, 5 Nov 2000 16:06:37 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Tim Riker <Tim@Rikers.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
Message-ID: <20001105160637.Z6207@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <E13s11X-0004TQ-00@the-village.bc.nu> <3A05C888.7558E0F0@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A05C888.7558E0F0@Rikers.org>; from Tim@Rikers.org on Sun, Nov 05, 2000 at 01:52:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 01:52:24PM -0700, Tim Riker wrote:
> Alan,
> 
> Perhaps I did not explain myself, or perhaps I misunderstand your
> comments. I was responding to a comment that we could just copy some of
> the optimizations from Pro64 over into gcc.

That's hard to do, because the whole gcc has copyright assigned to FSF,
which means that either gcc steering committee would have to make an
exception from this for SGI, or SGI would have to be willing to assign some
code to FSF.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
