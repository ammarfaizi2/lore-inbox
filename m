Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbRGKRQM>; Wed, 11 Jul 2001 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbRGKRQI>; Wed, 11 Jul 2001 13:16:08 -0400
Received: from ns.tulsyan.com ([216.5.0.102]:57612 "EHLO tuls1.tulsyan.com")
	by vger.kernel.org with ESMTP id <S267367AbRGKRPy>;
	Wed, 11 Jul 2001 13:15:54 -0400
Date: Wed, 11 Jul 2001 22:57:06 +0530 (IST)
From: <hanishkvc@fedtec.com>
Reply-To: <hanishkvc@fedtec.com>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>, <hanishkvc@hotmail.com>
Subject: a Preliminary Linux porting Guide draft, please give your feedback
 and corrections
In-Reply-To: <Pine.LNX.4.33.0107062023330.9400-300000@hanishkvc.fedtec.com>
Message-ID: <Pine.LNX.4.33.0107112237570.13619-100000@hanishkvc.fedtec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Over the last few weeks, I had looked into Linux from _porting
perspective_, but as there where no good porting guides, I thought I will
put down what  ever I find into a document format.

So I have uploaded it into my website

www.hanishkvc.com - my work/my documents section (Linux and Portability)

or if the direct link can be accesed then

http://hanishkvc.tripod.com/work/docs/LinuxAJourney.html

It talks about the Hardware Abstraction Layer of Linux, which one has to
update/modify in order for Linux to work on a new target.

So do go thro it, had give me your suggestions and any corrections.

Also a strange thing happened in that the earlier emails which I had sent
to the list along with the html doc as attachment never surfaced on the
list. I did that so that I can get feedback on it before I put it on my site.
However because of the problem, this time I haven't attached it to the
email.

So If anyone got this email earlier, then I apologize for this repeat. I
am sending this again as I will be happy to know as to how right or wrong
I am regarding Linux porting issues.

Keep :-)
HanishKVC


On Fri, 6 Jul 2001 hanishkvc@fedtec.com wrote:
> My earlier mail to the list seems to have gone into oblivion. So I am
> resending it. This is a preliminary attempt at describing the HAL related
> (porting) issues in Linux, If there are any errors in the document, or if
>
> On Tue, 3 Jul 2001, Hanish Menon C wrote:
> > Recently I have started looking into porting Linux to new targets and
> > boards. As part of it, when I couldn't find much documents to help me out,
> > I thought I will put some of the things I come across into a document form
> > and put it up for others.

