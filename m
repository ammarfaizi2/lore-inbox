Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265062AbSKFN0g>; Wed, 6 Nov 2002 08:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSKFN0g>; Wed, 6 Nov 2002 08:26:36 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:21400 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265062AbSKFN0e>; Wed, 6 Nov 2002 08:26:34 -0500
Subject: Re: [Evms-devel] Re: [Evms-announce] EVMS announcement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Visage <hvisage@envisage.co.za>
Cc: Mike Diehl <mdiehl@dominion.dyndns.org>, Kevin Corry <corryk@us.ibm.com>,
       evms-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021106093449.GE465@hvs.envisage.co.za>
References: <02110516191004.07074@boiler>
	<20021105214012.C2B4651CF@dominion.dyndns.org>
	<20021105215100.E927E51CF@dominion.dyndns.org>
	<1036542080.7386.24.camel@irongate.swansea.linux.org.uk> 
	<20021106093449.GE465@hvs.envisage.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 13:55:01 +0000
Message-Id: <1036590901.9781.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 09:34, Hendrik Visage wrote:
> On Wed, Nov 06, 2002 at 12:21:20AM +0000, Alan Cox wrote:
> > On Tue, 2002-11-05 at 21:11, Mike Diehl wrote:
> > > The biggest thing that EVMS had going for it was it's modular design.  As I 
> > > understand it, EVMS could even be used to manage the current MD and LVM 
> > > drivers.  I was looking forward to partition-level encryption, etc.  
> > 
> > Thats a seperate issue in the pile. You might want to do things like
> > 
> > 			lvm2 volumes
> 
> Quick question Alan: Are you saying that EVMS can't do this ??

The "one driver" model doesnt scale to it sanely. The EVMS tools
certainly can

