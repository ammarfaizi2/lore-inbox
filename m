Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRCXMwE>; Sat, 24 Mar 2001 07:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131660AbRCXMvy>; Sat, 24 Mar 2001 07:51:54 -0500
Received: from front4.grolier.fr ([194.158.96.54]:11648 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S131658AbRCXMvo> convert rfc822-to-8bit; Sat, 24 Mar 2001 07:51:44 -0500
Date: Sat, 24 Mar 2001 11:40:00 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "Stephen E. Clark" <sclark46@gte.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>, nick@snowman.net,
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABBDAFD.A679359D@gte.net>
Message-ID: <Pine.LNX.4.10.10103241107210.1060-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Stephen E. Clark wrote:

> Alan Cox wrote:
> > 
> > > You don't beleve me if I tell you: DOS extender and JVM (Java Virtual
> > > Machine)
> > 
> > The JVM doesnt actually. The JVM will itself spontaenously explode in real
> > life when out of memory. Maybe the JVM on a DOS extender 8)
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> Back in the early nineties I was working with 18 developers on a Data
> General Aviion running DGUX. The system had only 16mb of memory and
> 600mb of disk. We were all continuously going thru the edit, compile,
> debug steps developing as large Computer Aided Dispatch System. Never
> did this system with its limited resources crash, or randomly start
> killing user or system processes.

What about the following (it is an estimate):

early nineties  -->  early eighties
18 developers   -->  18 developers
16mb of memory  -->   1 mb of memory
600 mb of disk  -->  70 mb of disk

Most current applications are so huge BLOATAGE that they should not 
deserve to be run just once. :-)
The kernel must try to cope with that and also with its own BLOATAGE.

Human nature is to eat what can be eaten, regardless if it is useful or
not.

> My $.02.

What about 'My M$.02' in some decades. :)

Btw, 'decade' comes from Latin 'deca'=10 and dies=days (not sure for
dies). As a result, it should have meant a period of 10 days instead of 10
years. It means a period of 10 days in French.

May-be, a knowledgeable person at this list has an explanation for this
misinterpretation. Could it be due to the word 'decadent' that has a 
very different ethymology.

10 days is too short for getting decadent, but 10 years should be enough,
no ? :-)

> Steve

  Gérard.

