Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVKVQ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVKVQ4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVKVQ4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:56:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:36487 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965005AbVKVQ4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:56:39 -0500
Date: Tue, 22 Nov 2005 11:56:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122165638.GE32684@havoc.gtf.org>
References: <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org> <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org> <438349F4.2080405@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438349F4.2080405@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:40:20PM +0200, Avi Kivity wrote:
> Jeff Garzik wrote:
> 
> >On Tue, Nov 22, 2005 at 06:14:56PM +0200, Avi Kivity wrote:
> > 
> >
> >>You exaggerate. Windows drivers work well enough in Windows (or so I 
> >>presume). One just has to implement the environment these drivers 
> >>expect, very carefully.
> >>   
> >>
> >
> >I exaggerate nothing -- we have real world experience with ndiswrapper
> >and similar software, which is exactly the same model you proposed, is
> >exactly the same model that has created all sorts of technical, legal,
> >and political problems.
> > 
> >
> I agree that the legal and political problems are real. I offered two 
> solutions to the technical problems.

And given real world experience with "solutions" like this, they cause
more problems than they solve.


> However the situation with video drivers is already bad, and 
> deteriorating. I had to hunt on the Internet to get my recent (FC4) 
> distro to support my low-end embedded video (via). In the future it 
> looks like even that won't work.

VIA is working with open source community.  They are small enough
(comparatively) that they need every advantage.  VIA is one of the
positive examples.


> >Dumb with a capital 'D'.
> > 
> >
> I hope you have a better solution.

Almost all of the solutions listed in this thread are better:
Chinese wall rev-eng, funding, ...

	Jeff



