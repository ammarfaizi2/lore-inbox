Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317235AbSFCADa>; Sun, 2 Jun 2002 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317236AbSFCAD3>; Sun, 2 Jun 2002 20:03:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50429 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317235AbSFCAD2>; Sun, 2 Jun 2002 20:03:28 -0400
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020602233849.GA9381@zax>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Jun 2002 02:08:37 +0100
Message-Id: <1023066517.3439.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 00:38, David Gibson wrote:
> 
> On Wed, May 29, 2002 at 07:40:27PM +0100, Alan Cox wrote:
> > On Thu, 2002-05-23 at 02:25, David Gibson wrote:
> > > The signal/noise bit is probably a red herring.  We have problems with
> > > the reporting of this, but it's mostly cosmetic.  I seem to have
> > > confusing and contradictory information about how to interpret the
> > > values the firmware reports.
> > 
> > Ok the old driver gets the noise level right, the newer one got it
> > wrong, the current one gets it wrong. The good news is the old one
> > works, the new one didnt, the current 2.4.19pre one does...
> 
> Um, ok, now I'm a bit lost.  I'm guessing by "old driver" you mean the
> pre 2.4.18 one (0.06f?) by "new driver" you mean the one in 2.4.18 and
> "current driver" means the one in 2.4.19pre (0.11b) - i.e. newer than
> the "new" one.  Is that right?

It is right.

