Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbSLRWBd>; Wed, 18 Dec 2002 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbSLRWBK>; Wed, 18 Dec 2002 17:01:10 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54801
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267407AbSLRWA7>; Wed, 18 Dec 2002 17:00:59 -0500
Date: Wed, 18 Dec 2002 14:06:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Chua <jchua@fedex.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 ide module problem
In-Reply-To: <1040251422.26521.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10212181404180.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff,

Everybody cried screamed an whinned about making the chipsets modular.
Now that we are going do that path, you have no choice but to wait.
Use 2.4.20 and be happy.  Or have FedEX write the check for it to be
worked on fulltime.  I do not care which, but don't bitch about progress.


On 18 Dec 2002, Alan Cox wrote:

> On Wed, 2002-12-18 at 19:50, Jeff Chua wrote:
> > 
> > On 18 Dec 2002, Alan Cox wrote:
> > 
> > > I'll get back to 2.5 IDE things next year. For the moment I'm only
> > > concerned in getting the modular stuff sorted out completely in 2.4.
> > > Hopefully that will be mostly valid for 2.5 as well.
> > 
> > I can't even boot 2.4.21-pre1 with IDE as modules. Works fine under 2.4.20
> > 
> > Looks like the IDE patch for 2.4.21-pre1 broke up the modules very similar
> > to 2.5.51
> 
> Yes it did, and I plan to fix it there first
> 

Andre Hedrick
LAD Storage Consulting Group

