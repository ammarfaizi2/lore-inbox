Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbTALUz2>; Sun, 12 Jan 2003 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTALUz2>; Sun, 12 Jan 2003 15:55:28 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:22708 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267392AbTALUzV>; Sun, 12 Jan 2003 15:55:21 -0500
Date: Sun, 12 Jan 2003 16:02:12 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <1042403499.834.91.camel@phantasy>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042405331.1208.109.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <1042403499.834.91.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Love,

I posted a minor change to the floppy driver which no one commented on
earlier (probably in wrong form)-- three times now (once in unified diff
format).. And you might even say that the message you quoted was kernel
code that I was posting since I posted alternate code to linus' code.

As per whether I post more than the developers here, it's only because I
don't have a job, so I've got more free time than they do.  I can't help
it.  If they're busier than me, I wouldn't expect them to waste time
writing conversational messages about the kernel.  

-Rob

On Sun, 2003-01-12 at 15:31, Robert Love wrote:
> On Sun, 2003-01-12 at 14:34, Rob Wilkens wrote:
> 
> > I'm REALLY opposed to the use of the word "goto" in any code where
> > it's not needed.  OF course, I'm a linux kernel newbie, so I'm in
> > no position to comment
> 
> We use goto's extensively in the kernel.  They generate fast, tight
> code.
> 
> There is nothing wrong with being a newbie, but there is something wrong
> with voicing ignorance.  "Learn first, form opinions later".
> 
> When you start posting more than most of the developers here, combined,
> and none of your posts are contributive kernel code, there is a problem.
> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

