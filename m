Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSE2AOT>; Tue, 28 May 2002 20:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSE2AOS>; Tue, 28 May 2002 20:14:18 -0400
Received: from pc132.utati.net ([216.143.22.132]:59299 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S312486AbSE2AOS>; Tue, 28 May 2002 20:14:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Date: Tue, 28 May 2002 10:09:04 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10205261716410.3010-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020529004327.852457C7@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 May 2002 08:17 pm, Andre Hedrick wrote:
> On 27 May 2002, Alan Cox wrote:
> > On Mon, 2002-05-27 at 00:08, Andre Hedrick wrote:
> > > All of the original code described how to make the hardware operate. 
> > > If your code makes the hardware operate, then it uses material
> > > copyrighted and owned by me.
> >
> > Really. You think if I read a GPL'd example of a piece of code I can't
> > write a non GPL'd one. Companies use two sets of people to ensure that
>
> It is one thing to take and read a GPL code and write non-GPL.
> This is different from taking GPL code and writing another GPL code.

Not from a legal standpoint, no.

Licensing is seperate from copyright.  A copyright exists on creation of the 
code, before any license is issued.  It is perfectly valid for a copyright to 
exist for which no license has been issued, in which case only the copyright 
holder is allowed to make copies.  (Back in the days of paper and ink, you 
didn't usually get a legal document bundled with your newspaper, did you?  
That's because they weren't giving you any permission to make copies of it 
period, they made the copy and you bought that copy, and that was all the 
copying expected to occur.  With computers, they can't help BUT copy.  
Loading from disk into memory is copying, and non-techie judges have no idea 
what constitutes "fair use" in this space, and the most legally saavy dude 
back around 1980 when the relevant case law was being fought over in court 
seems to have been a greedy harvard law school dropout from Seattle...)

The issuing of a license does not actually transfer a copyright.  (You can 
give away a copyright, but that's NOT licensing, it falls more under the 
heading of contract law.)

(No, I'm not a lawyer, but I could mail you my old Business Law textbook if 
you think it would help.  Have to figure out which box it's in first...)

> > Rude yes, but derived work.. open question. I guess Eben can give you a
> > reasonably sane opinion if its so important.
>
> Andre Hedrick
> LAD Storage Consulting Group

Any decent introduction to copyright (and licensing) should cover what 
copyright law ISN'T, and it isn't trademark law, patent law, contract law, or 
the mess known as "trade secrets".  (It can interact with all the above, but 
let's not open that can of worms right now...)

An NDA like you mentioned earlier would be using contract law to preserve a 
trade secret status, and as soon as you got permission to publish a GPL 
driver, any potential trade secret status went bye-bye.  (If you screwed up 
in that release, the trade secret status is probably still popped since 
Vojtech isn't bound by a patent he didn't sign and he was definitely acting 
in good faith: the trade secret holder's remedies would basically be against 
you, the signer of the NDA.  Lawyers can go after trade secrets on a sort of 
"trafficing in stolen goods" theory (the theory behind the decss nonsense), 
but that's pretty clearly not the case here and you haven't got the money to 
buy a judge.)

Yeah, all this is modulo companies with deep pockets to fund frivolous 
lawsuits, clueless/biased judges, and the crawling horrors known as the DMCA 
and UCITA.  But you're not really in a position to make much use of any of 
those, Andre.  You aren't stinking rich. :)

Rob

(Now if you're complaining that the lack of attribution was impolite, and 
trying to use social norms to get a "based on" citation as a sort of author's 
credit for the brownie point value, by all means.  But screaming about 
legalities isn't a very good way to do it.  Try going for guilt here, not 
lawyers. :)

