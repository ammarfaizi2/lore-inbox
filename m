Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVKWPqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVKWPqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKWPqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:46:07 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:15009 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751065AbVKWPqF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:46:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TOx+fWicbDBcNMyCnPrYIWpwz10JdR+5TvfeibnYryEn0m6OrpN1nizPikNJ2IK9ynEE4Hr2xE9pCnK42y5YM7Hn8fdQKG46/lEmyd+8ojShkmhzFvTPK5CFptPYTNJFBhRE4hla3+wRkltOjCm9wVReExGR++dbg/G/Ei9C3IU=
Message-ID: <9a8748490511230746y762a3455y381f46b61c0b9913@mail.gmail.com>
Date: Wed, 23 Nov 2005 16:46:03 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC] Small PCI core patch
Cc: Neil Brown <neilb@suse.de>, Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051122192857.GB3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
	 <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	 <17282.39560.978065.606788@cse.unsw.edu.au>
	 <20051122192857.GB3963@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Tue, Nov 22, 2005 at 03:11:52PM +1100, Neil Brown wrote:
> > On Monday November 21, jonsmirl@gmail.com wrote:
> > >
> > > 2) Temporarily accept the ugly drivers. Let desktop development
> > > continue. Work hard on getting the vendors to see the light and go
> > > open source.
> >
> > I doubt they will see 'the light' for many years without dollar signs
> > attached.
> >
> > A question worth asking is: Who needs whom?  Do we (FLOSS community)
> > need them (Graphics hardware manufactures) or do they need us?
> > Despite growth in Linux on Desktops, I think we need them a lot more
> > than they need us.
> >...
> > Who is going to pay these people to do this work?  If you agree with
> > the analysis of 'who needs whom', the logical answer is 'us'.
> >
> > Maybe we need a small consortium of companies with vested interest in
> > OSS each ponying up half a million, and use this to employ two teams
> > of graphics experts, one of which works within NVidia, and one within
> > ATI.  I suspect the two companies could be convinced to take on some
> > free engineering support, if it was presented the right way.
> >...
>
> There might be a different way that could work if _many_ Linux-related
> companies participate:
>
> Find a graphics card vendor who wants to offer a cheap graphics card
> while offering full specs and write an open source driver for this card.
>

Or throw resources behind the OpenGraphics project (
http://www.opengraphics.org/ ). Help them out with the hardware specs,
help out with the code. Then when the hardware finally arrives, help
out by buying and using that hardware.
That'll give you a fully Open Source supported graphics card.


> Then start the PR campaign, e.g. press releases and free prominent
> notices at the SuSE main page "SuSE recommends ...".
>
> Yes, this would require a significant joint effort.
>
> But if successful, it might convince at least one of the two big
> graphics cards vendors that there's an (although relatively small) part
> of the market they are missing.
>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
