Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKEU6e>; Sun, 5 Nov 2000 15:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbQKEU6Y>; Sun, 5 Nov 2000 15:58:24 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:42092 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129121AbQKEU6M>;
	Sun, 5 Nov 2000 15:58:12 -0500
Message-ID: <3A05C888.7558E0F0@Rikers.org>
Date: Sun, 05 Nov 2000 13:52:24 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9vaio i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <E13s11X-0004TQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Perhaps I did not explain myself, or perhaps I misunderstand your
comments. I was responding to a comment that we could just copy some of
the optimizations from Pro64 over into gcc. Whether Pro64 understands
gcc syntax is immaterial to this question is it not?

Tim

Alan Cox wrote:
> 
> > This is also a nice thought, but there is an obstacle.
> > The Pro64 tools are Open Source and GPLed:
> >
> > http://oss.sgi.com/projects/Pro64/
> >
> > SGI retains the copyright to the code.
> >
> > As far as I know, the FSF owns the copyright to all code in the gcc
> > suite. If improvements were taken from the Pro64 tools the copyright to
> > said code would have to remain.
> 
> Pro64 is free software and Pro64 understands gcc syntax. No problem at all.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
