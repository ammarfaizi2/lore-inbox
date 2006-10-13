Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWJMVui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWJMVui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWJMVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:50:38 -0400
Received: from web83101.mail.mud.yahoo.com ([216.252.101.30]:25533 "HELO
	web83101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030192AbWJMVuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:50:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=O+lOpeNbtcbRSR6PX2HneQD2FdDDBFbh1MSX2xj4zD9DE5wGzXV3sYZzbsXtyu3iCfq7thhDEZDvLDCZ97fnqieTdF6NFHnC7lpJ6nM3TdHc7Aw7joqfRtVFT0ZmciGj0htY6OBBVPFzgIitaJ6rObuO65Pi9p692cYGZ+NibSU=  ;
Message-ID: <20061013215036.68271.qmail@web83101.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 14:50:36 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
To: Ryan Richter <ryan@tau.solarneutrino.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
In-Reply-To: <20061013214608.GD19608@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ryan Richter <ryan@tau.solarneutrino.net> wrote:

> On Fri, Oct 13, 2006 at 11:45:23PM +0200, Lukas Hejtmanek wrote:
> > On Fri, Oct 13, 2006 at 05:42:50PM -0400, Ryan Richter wrote:
> > > >   The similar issue has been discussed in adjacent thread "Machine
> > > >   reboot". Is it Intel motherboard, or just carries Intel chipset ?
> > > >   Does building e1000 driver as a module and 'rmmod e1000' just before
> > > >   reboot help ?
> > > 
> > > It's an Intel DG965RY board.  I'll try out your suggestion on Monday.
> > 
> > Btw, are you using i386 or x86_64 architecture?
> 
> x86_64.
> 
And mine is i386.

Aleks.

