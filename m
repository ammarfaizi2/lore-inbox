Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTALRsE>; Sun, 12 Jan 2003 12:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbTALRsE>; Sun, 12 Jan 2003 12:48:04 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:13636 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267368AbTALRsC>; Sun, 12 Jan 2003 12:48:02 -0500
Date: Sun, 12 Jan 2003 12:54:53 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Linux VM Documentation - Draft 1
In-reply-to: <Pine.LNX.4.44.0301121532160.24444-100000@skynet>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Marcus Alanen <marcus@infa.abo.fi>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042394092.3162.16.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121532160.24444-100000@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 10:36, Mel Gorman wrote:
> I wasn't sure how suitable patches would be for documentation but I'll try
> anything once. A tar ball of the current tex source is at
> http://www.csn.ul.ie/~mel/projects/vm/guide/vm_book.tar.gz . There is a
> CVS tree but it's on a computer thats already heavily loaded so I don't
> want to have it hammered.
> 
> The tex sources are in tex/understand and tex/code . To create a DVI,
> simply ./make dvi . If you add "understand" or "code", it'll just generate
> that book.

Not worthy of re-releasing but one small "patch" is page 16 of the pdf
(labelled as page 9 on the top) which reads:
	"the init code is quiet architecture dependent"
but should probably read
	"the init code is quite architecture dependent"
It's a small thing, but whenever I read a technical document and see
small errors like that, it distracts me from the main point of the
article and makes concentrating on the original document harder.

I don't know how to code in tex (maybe one of these years I should
learn), otherwise I'd offer a tex patch for you to apply.  

I'm sure I'm not the first to catch that error, given the number of
people who are probably interested in the article you wrote, it's quite
a document.  It was also very nice of you to share it with the world
gratis.

-Rob

