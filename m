Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264880AbSJVVwC>; Tue, 22 Oct 2002 17:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSJVVwC>; Tue, 22 Oct 2002 17:52:02 -0400
Received: from fmr02.intel.com ([192.55.52.25]:6870 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264880AbSJVVwB>; Tue, 22 Oct 2002 17:52:01 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC826@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Corey Minyard <cminyard@mvista.com>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Cahill, Ben M" <ben.m.cahill@intel.com>,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       "Sousou, Imad" <imad.sousou@intel.com>
Subject: RE: [PATCH] IPMI driver for Linux, version 7
Date: Tue, 22 Oct 2002 14:58:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, 2002-10-20 at 22:05, Corey Minyard wrote:
> > >Am I right that this makes it impossible to include an 
> > > IPMI driver into the kernel (this isn't GPL-compatible)?
> > >
> > I do not read it so, but perhaps you are right.  I will 
> > ask.  I'm sure I 
> > will receive a resounding "maybe" as the answer.  I was 
> > working with 
> > people at Intel on this, and they had another driver they 
> > wanted to use 
> > for IPMI, and wanted to push it into the kernel, but it had some 
> > problems so I wrote this as a replacement.  So I don't 
> > think Intel sees 
> > it this way (at least those at Intel I was working with).
> 
> Intel tend to see everything Intel's way. Perhaps someone from Intel
> could clarify this situation - on list ?
> 
> I'd hate us to have to have an IPMI driver that US citizens 
> couldnt use

Corey's IPMI driver is GPL, as are all the other components
of the kernel. People who are worried about patents on IPMI
implementations can get a royalty-free license any time by
going to http://www.intel.com/design/servers/ipmi/spec.htm 
and signing the Adopter's agreement. Yes, to get the royalty-free 
patent license for implementations of the IPMI spec, you have 
to give a promise not to sue other Adopters of IPMI, but I don't 
see why anyone who isn't planning on going around suing people 
should have a problem signing this agreement. In any case this 
is very similar to USB, which also has an Adopter's agreement 
for patents, and USB has been in the kernel for years without 
causing any IP problems.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

