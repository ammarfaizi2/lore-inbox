Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQKEVYJ>; Sun, 5 Nov 2000 16:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbQKEVX7>; Sun, 5 Nov 2000 16:23:59 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:23407 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129110AbQKEVXz>;
	Sun, 5 Nov 2000 16:23:55 -0500
Message-ID: <3A05CE91.3979B1B6@Rikers.org>
Date: Sun, 05 Nov 2000 14:18:09 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9vaio i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <E13s11X-0004TQ-00@the-village.bc.nu> <3A05C888.7558E0F0@Rikers.org> <20001105160637.Z6207@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, exactly what my comments stated.

Jakub Jelinek wrote:
> 
> On Sun, Nov 05, 2000 at 01:52:24PM -0700, Tim Riker wrote:
> > Alan,
> >
> > Perhaps I did not explain myself, or perhaps I misunderstand your
> > comments. I was responding to a comment that we could just copy some of
> > the optimizations from Pro64 over into gcc.
> 
> That's hard to do, because the whole gcc has copyright assigned to FSF,
> which means that either gcc steering committee would have to make an
> exception from this for SGI, or SGI would have to be willing to assign some
> code to FSF.
> 
>         Jakub

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
