Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUDPMdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUDPMdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:33:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262974AbUDPMdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:33:02 -0400
Date: Fri, 16 Apr 2004 13:37:09 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200404161237.i3GCb9Jf000164@81-2-122-30.bradfords.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040416102820.GD14796@devserv.devel.redhat.com>
References: <Pine.LNX.4.10.10404160259480.22035-100000@master.linux-ide.org>
 <200404161020.i3GAKSv9000256@81-2-122-30.bradfords.org.uk>
 <1082111045.9600.0.camel@laptop.fenrus.com>
 <200404161030.i3GAUrcB000356@81-2-122-30.bradfords.org.uk>
 <20040416102820.GD14796@devserv.devel.redhat.com>
Subject: Re: SATA support merge in 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Arjan van de Ven <arjanv@redhat.com>:
> 
> --g7w8+K/95kPelPD2
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Fri, Apr 16, 2004 at 11:30:53AM +0100, John Bradford wrote:
> > Quote from Arjan van de Ven <arjanv@redhat.com>:
> > > 
> > > --=-De0mPL9BnMYZGB8TurTV
> > > Content-Type: text/plain
> > > Content-Transfer-Encoding: quoted-printable
> > > 
> > > On Fri, 2004-04-16 at 12:20, John Bradford wrote:
> > > > Quote from Andre Hedrick <andre@linux-ide.org>:
> > > > > You are suggesting that 2.6 is not stable ?  How could that be ?
> > > >=20
> > > > It hasn't exactly been audited for security issues yet.
> > > 
> > > neither has the biggest part of the 2.4 codebase.
> > 
> > A valid point, but last time I checked, there were known exploits that had
> > been fixed in 2.4 but not in 2.6.
> 
> maybe you should check again and report what you find because I for sure
> can't think of any.

I honestly don't have the time to go through the archives at the moment, and
having been busy, I could well have missed any fixes that have gone in during
the last couple of releases, but I am 99% sure that Alan identified a couple
of local root exploits around 2.6.0 that had been fixed in 2.4 but never
applied to 2.6.

John.
