Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132950AbRBRPMg>; Sun, 18 Feb 2001 10:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132980AbRBRPM0>; Sun, 18 Feb 2001 10:12:26 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1042 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132950AbRBRPMV>; Sun, 18 Feb 2001 10:12:21 -0500
Date: Sun, 18 Feb 2001 09:05:34 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Grant Grundler <grundler@cup.hp.com>
cc: Philipp Rumpf <prumpf@mandrakesoft.mandrakesoft.com>,
        Tim Waugh <twaugh@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug 
In-Reply-To: <200102141725.JAA11515@milano.cup.hp.com>
Message-ID: <Pine.LNX.3.96.1010218090322.1287D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Grant Grundler wrote:

> Philipp Rumpf wrote:
> > Jeff Garzik wrote:
> > > Looks ok, but I wonder if we should include this list in the docs.
> > > These is stuff defined by the PCI spec, and this list could potentially
> > > get longer...  (opinions either way wanted...)
> 
> Having people look things up in the spec isn't very user friendly.
> Finding a copy of the PCI 2.1 or 2.2 spec I could pass on to others
> (outside of HP) was a problem last year. The best I could do then
> (legally) was point them to "PCI Systems Architecture" published
> by MindShare.

_PCI Systems Architecture_ is an awesome book, definitely.

AFAIK there are two avenues to go, when getting the PCI specs.
Become a PCI SIG member (much $$$), or buy a CD-ROM.

For US$50, a non-member can purchase a CD-ROM from the PCI SIG
which includes the latest versions of all the PCI specifications,
in PDF format, as well as a hardcopy of the PCI 2.2 spec itself.
Great deal, I recommend it for anybody intersted in hacking PCI.

	Jeff




