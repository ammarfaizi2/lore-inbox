Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272188AbRH3Mec>; Thu, 30 Aug 2001 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272191AbRH3MeN>; Thu, 30 Aug 2001 08:34:13 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:34570 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S272188AbRH3MeD> convert rfc822-to-8bit; Thu, 30 Aug 2001 08:34:03 -0400
Subject: Re: smp freeze on 2.4.9
From: Philippe Amelant <philippe.amelant@free.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010830221733.A3834@higherplane.net>
In-Reply-To: <999166237.1257.31.camel@avior> 
	<20010830221733.A3834@higherplane.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 30 Aug 2001 14:34:15 +0200
Message-Id: <999174855.2667.4.camel@avior>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On jeu, 2001-08-30 at 14:17, john slee wrote:
> On Thu, Aug 30, 2001 at 12:10:37PM +0200, Philippe Amelant wrote:
> > I have an ABIT BP6 mobo with 2 celeron 400 running redhat 7.1 with 2.4.3
> 
> before you blame smp, try the usual bp6 stuff:
> *	bigger/better power supply

350 W should be enough (just 1 HD and 1 DVD + mobo ) ?

> *	better cooling

I have 2 big fan :)
cpu temp is typically 35 °C

> *	boot with 'noapic' on commandline
> 

interresting, i notice that i have some error apic in kernel message
with 2.4.3
i will search that on lkml archive

thank for response

> search a linux-kernel archive (http://marc.theaimsgroup.com)
> for more info.  these boards seem to be a bit of a lucky dip.  some
> never have any problems, others have heaps.  i have a vague memory of
> someone mentioning flaky caps on some revisions...  also are you using
> the onboard ata66 controller?  there's been a fair few reports of
> trouble with those, not sure if it was fixed/hacked-around or not.
> 
> best of luck,
> 
> j.
> 


