Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268747AbTGIXfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbTGIXeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:34:12 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:15866 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S268709AbTGIXdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:33:44 -0400
Message-ID: <038801c34674$91f5c6a0$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <marcel@mesa.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <20030709195609.GA16563@joshua.mesa.nl>
Subject: Re: Promise SATA 150 TX2 plus
Date: Thu, 10 Jul 2003 01:48:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where have you seen this card working? Is any contact to sysadmin of that
system?
I asked support@promise.nl, because I am from Europe and now I had send them
configuration of my system and the problem description, so I will see later
if any sollution come.
Thanx for the answer
    Milan Roubal

----- Original Message ----- 
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 09, 2003 9:56 PM
Subject: Re: Promise SATA 150 TX2 plus


> On Wed, Jul 09, 2003 at 03:34:51PM +0200, Milan Roubal wrote:
> > Thanks for the answer, it has got PDC 20375, not
> > 20376, but it changes nothing. As Alan mentioned
>
> You could try asking the PROMISE Linux support team
<support@promise.com.tw>
> for their driver.  I have seen a working driver on a 20376 chip with just
> one disk connected to it.
>
> -Marcel
>
>  > here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
> > promise has got their own drivers. Have somebody seen
> > this drivers really working? My card is not RAID,
> > its only controller, I want only see the harddrives.
> > Thanx a lot
> >     Milan Roubal
> >
> > ----- Original Message ----- 
> > From: <Mitch@0Bits.COM>
> > To: <linux-kernel@vger.kernel.org>
> > Cc: <roubm9am@barbora.ms.mff.cuni.cz>
> > Sent: Wednesday, July 09, 2003 3:16 PM
> > Subject: Re: Promise SATA 150 TX2 plus
> >
> >
> > >
> > > I believe that is the Promise PDC 20736 controller
> > > for which there is no current driver yet. Search in
> > >
> > > http://marc.theaimsgroup.com/?l=linux-kernel&r=1&b=200307&w=2
> > >
> > > for "20736" and read the thread(s) there.
> > >
> > > Cheers
> > > M
> > >
> > > Milan Roubal wrote:
> > > > Hi,
> > > > I got one card SATA 150 TX2 plus with version v1.00.0.20 on chip.
> > > > I want to make it working under SuSE linux 8.0. I have downloaded
> > > > drivers from www.promise.com, but driver is not working, because of
bad
> > > > major/minor numbers of /dev/sda, /dev/sda1, /dev/sdb, .....
> > > > What are the major/minor numbers for making it work?
> > > >
> > > > Or is there any other driver that I should use for making this card
=
> > > > working?
> > > > What are major/minor numbers for that drivers?
> > > > Thanks very much for your answers.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -- 
>      ======--------         Marcel J.E. Mol                MESA Consulting
B.V.
>     =======---------        ph. +31-(0)6-54724868          P.O. Box 112
>     =======---------        marcel@mesa.nl                 2630 AC
Nootdorp
> __==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands
____
>  They couldn't think of a number,           Linux user 1148  -- 
counter.li.org
>     so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

