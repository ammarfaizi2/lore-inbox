Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRARKFS>; Thu, 18 Jan 2001 05:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133059AbRARKFI>; Thu, 18 Jan 2001 05:05:08 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:44048
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132734AbRARKFD>; Thu, 18 Jan 2001 05:05:03 -0500
Date: Thu, 18 Jan 2001 02:01:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Dan Hollis <goemon@sasami.anime.net>, Martin Mares <mj@suse.cz>,
        Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
In-Reply-To: <Pine.GSO.3.96.1010118092306.8140D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.10.10101180133460.20569-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Maciej W. Rozycki wrote:

> On Wed, 17 Jan 2001, Dan Hollis wrote:
> 
> > They require not only an NDA, but that you also do all development on-site
> > at their santa clara HQ under their direct supervision.
> 
>  I haven't went that far -- I'm not going to sign any NDA anytime soon, so
> I haven't asked them for details.  I recall someone writing here it's
> restrictive, indeed. 
> 
> > The only people who have ever got info out of serverworks are the lm78
> > guys and (i think) andre hedrick.

I can get any info needed, you just have to define the scope.
Then will not can and will not give out details on a generic form.
In short no one person can see the entire design docs or will they get
them without a NDA.  I have seen why this is the case, cause the toy are
cool.

>  I was asking for a few I/O APIC details -- apparently there are problems
> with 8254 interoperability and we have to use the awkward through-8259A
> mode for the timer tick.

Narrow the point.

> > What magic incantations they chanted, or which mafia thugs they hired to
> > manage this, I don't know...
> 
>  And I don't actually care.  If they want to lose in the Linux area, it's
> their own choice. 

You don't get it, they OEM board designs for Compaq and Dell.
These guys will work with you on-site but in their sand-box not yours.
I wish I could say more, but I have something more powerfully than any NDA
ever written.  I have given my word and a handshake, and that has more
value to me than any stupid NDA.  The very fact that I value this so much
and so many in the industry know this about me, I have been shown things
without NDA's that you never see otherwise.

They are very friendly to Linux, but can we be friendly to them?
You just can not barge in and demand to see their IP.

Regards,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
