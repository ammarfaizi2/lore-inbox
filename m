Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262926AbTCSFv7>; Wed, 19 Mar 2003 00:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTCSFv7>; Wed, 19 Mar 2003 00:51:59 -0500
Received: from [213.171.53.133] ([213.171.53.133]:8198 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S262926AbTCSFv6>;
	Wed, 19 Mar 2003 00:51:58 -0500
Date: Wed, 19 Mar 2003 09:02:41 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: Fw: Re: DAC960 in 2.5.59 vs modem
Message-Id: <20030319090241.3bb7d954.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Begin forwarded message:

Date: Wed, 19 Mar 2003 09:02:16 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: Dave Olien <dmo@osdl.org>
Subject: Re: DAC960 in 2.5.59 vs modem


On Tue, 18 Mar 2003 15:50:33 -0800
Dave Olien <dmo@osdl.org> wrote:

> 
> Sorry, I've not exactly forgotten about you.  But, I'm stumped.
don`t worry, situation far from critical out there :-)

> Especially since the problem shows up on both 2.5 and 2.4.19.
> 
> When you say DAC960 kills your ppp connection, are talking about
> carrier being dropped over the modem, or some kind of data corrupction?
yes, the carrier is dropped

> 
> Is it possible you have an issue with power supply, that when the
> disk accesses are frequent, the power supply voltage drops and your
> modem drops because of the voltage drop?
hmmmm, i have two PSU`s with disks being powered independently from
the motherboard/cpu/etc...

> 
> I'm having a hard time thinking of any software interaction, expecially
> one that wouldn't cause data corruption on your DAC960, for example.
> 
> 
> On Fri, Mar 14, 2003 at 04:41:32PM +0300, Samium Gromoff wrote:
> > On Thu, 13 Mar 2003 16:39:26 +0300
> > Samium Gromoff <deepfire@ibe.miee.ru> wrote:
> > 
> > > 	The matters are quite simple: any disk acces to the drives on my
> >  Just to clarify the issue a bit:
> >   not exactly _any_, but any substantiable will do, i.e. very very light
> >  accesses are tolerable so some degree.
> > 
> > >   DAC960PL tends to kill my ppp connection. that is on a p3-600.
> > > 
> > > regards, Samium Gromoff
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
