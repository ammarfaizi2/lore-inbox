Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129298AbQKMIoG>; Mon, 13 Nov 2000 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129296AbQKMIn4>; Mon, 13 Nov 2000 03:43:56 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:58823 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129135AbQKMInn>; Mon, 13 Nov 2000 03:43:43 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Date: Mon, 13 Nov 2000 08:41:03 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.3.95.1001107174352.436A-100000@chaos.analogic.com> <20001111202655.A22628@cerebro.laendle> <20001112232202.B15166@vger.timpanogas.org>
In-Reply-To: <20001112232202.B15166@vger.timpanogas.org>
MIME-Version: 1.0
Message-Id: <00111308433800.19602@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Jeff V. Merkey wrote:
> On Sat, Nov 11, 2000 at 08:26:55PM +0100, Marc Lehmann wrote:
> > On Tue, Nov 07, 2000 at 04:03:25PM -0700, "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> > > 
> > > Marc Lehman verified that PII systems will generate tons of AGIs with
> > > gcc. 
> > 
> > It is a bit late (just came back from the systems'00 fair), but Jeff
> > Merkey just acknowledged that indeed he meant me with "Marc Lehman". I
> > have no idea why he wrote such a thing, since I never mentioned something
> > like that, nor did I verify anything like this (given that the sentence
> > doesn't make much sense, either).
> > 
> > Jeff, I never said such a thing and I would appreciate if you didn't put
> > your words into my mouth.
> 
> I can go and get the text from our discussion, and I distinctly remember
> your answer to this question on PII and you said "lots".  This was also a 
> private email correspondence between us based on my review.  I also 
> verified what you told me, and you were right .  On PII, it generated
> lots....

I wouldn't swear it was Marc, but I do remember seeing a thread in which
someone did confirm this. Jeff posted an example code segment which would
generate an AGI, and gcc generated a lot of code like this (i.e. it doesn't
avoid generating AGIs). Someone (Marc??) supported this.

He didn't state directly "gcc code produces lots of AGIs", but did say that gcc
generated a lot of code which, according to Jeff, produces AGIs.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
