Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281936AbRKURf0>; Wed, 21 Nov 2001 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281934AbRKURfQ>; Wed, 21 Nov 2001 12:35:16 -0500
Received: from maild.telia.com ([194.22.190.101]:16069 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S281927AbRKURfD>;
	Wed, 21 Nov 2001 12:35:03 -0500
Message-Id: <200111211734.fALHYla18640@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: marcel@mesa.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New ac patch???
Date: Wed, 21 Nov 2001 18:34:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dominik Kubla <kubla@sciobyte.de>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
In-Reply-To: <20011121120033.C21032@duron.intern.kubla.de> <E166VIr-0004ik-00@the-village.bc.nu> <20011121132333.F15851@joshua.mesa.nl>
In-Reply-To: <20011121132333.F15851@joshua.mesa.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesdayen den 21 November 2001 13.23, Marcel J.E. Mol wrote:
> On Wed, Nov 21, 2001 at 11:12:28AM +0000, Alan Cox wrote:
> > > > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it
> > > > is IBM but the logs do not show a brandname. I can try open up the
> > > > case tonight if you want to know for sure?
> > >
> > > It's an IBM IC25T048ATDA05-0 to be precise.
> >
> > Thanks. It seems IBM laptop drives are the ones that specifically need
> > this fix. That ties in with the windows 98 reports/microsoft fixes.
>
> Would that be enough reason to add only the specific flushing code of
> the taskfile patch (if at all possible) to the kernel? Maybe Andre is
> willing to extract the relevant code in a seperate patch...
>
> -Marcel

This also affects my Desktop PC with two IBM Deskstar 60GXP 40GB drives. I'd 
like to see it in 2.4.15.

/Jakob

