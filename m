Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRKNPXa>; Wed, 14 Nov 2001 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280634AbRKNPXU>; Wed, 14 Nov 2001 10:23:20 -0500
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:15621 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S280635AbRKNPXI>;
	Wed, 14 Nov 2001 10:23:08 -0500
Date: Wed, 14 Nov 2001 07:25:56 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: fdutils.
In-Reply-To: <Pine.GSO.3.96.1011114131910.9644C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.10.10111140704310.9397-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Maciej W. Rozycki wrote:

> On Tue, 13 Nov 2001, Gerhard Mack wrote:
> 
> > >  You only confirm what I wrote -- hardly anyone uses floppies, so there is
> > > no need to keep mechanical compatibility in devices -- a complete dump of
> > > 1.44" FD support would be almost harmless.  Hence whether a Zip or a
> > > LS-120 -- it doesn't really matter.  You need new media anyway. 
> > 
> > What an interesting thing to be reading as I'm reinstalling linux on a
> > server using a combination of boot/root floppies and a network install.
> 
>  Or a single Zip, LS-120, etc. medium...  Is that worse?

Zip is best defined by it's total lack of quality, I can't keep those
around for long before they either break or become unsupported when they
release a larger drive and as much as I wish LS-120 was a standard
feature.. it's not.

I can't use CDs because I often need something custom.  Just try booting a  
Dell PowerEdge using the standard Debian install CD, it won't work (needs
custom patched kernel).  Removing floppy support would be a shafting of
monumental proportions.

As much as I hate floppies, I'm stuck with em.  I doubt I'm the only one
either.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

