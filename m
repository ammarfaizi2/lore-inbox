Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSCKS24>; Mon, 11 Mar 2002 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSCKS2r>; Mon, 11 Mar 2002 13:28:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62214
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285424AbSCKS2j>; Mon, 11 Mar 2002 13:28:39 -0500
Date: Mon, 11 Mar 2002 10:27:36 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kUED-0001GB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203111018460.10583-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alan Cox wrote:

> > Does the fact that MS XP Service Pack #2 having as similar taskfile
> > command passthrough method mean anything ... Oh Oh, but there is no
> > Service Pack #1 how could one know this ... guess my friend some of us are
> > in the business and you are trying to get there and I wish you success.
> 
> Actually helping him by getting him info like that would be perhaps more
> productive than grinning from on high ?

I would but he is equivalent to Linus and will not listen to facts.

> > Funny you should mention that point ... The "flagged taskfile code" is a
> > project to allow for NATIVE DFT support in Linux.  Nice screw job you did
> > to IBM.
> 
> Ok so whats native DFT and where does he (and I for that matter) read about
> it ?
> 
> > The SPEC does does not address CFA hardware, goto CFA to get their ruleset.
> 
> The URL is http://www.compactflash.org/specdl1.htm btw if anyone wants that
> one. Its got fun stuff like how to password protect your cf cards but I
> don't seem to remember PM stuff in it ?

Sorry there is a mix up, since MicroDrives are fixed disk that miss report
by design, you have mix the two to get it right.  However I will check
with IBM again on the specifics for you.

Cheers,

Andre Hedrick
The Second Linux X-IDE guy

