Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbTGITmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbTGITmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:42:21 -0400
Received: from doortje.mesa.nl ([80.126.82.97]:49156 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id S268490AbTGITlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:41:39 -0400
Date: Wed, 9 Jul 2003 21:56:09 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise SATA 150 TX2 plus
Message-ID: <20030709195609.GA16563@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027901c3461e$e023c670$401a71c3@izidor>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 03:34:51PM +0200, Milan Roubal wrote:
> Thanks for the answer, it has got PDC 20375, not
> 20376, but it changes nothing. As Alan mentioned

You could try asking the PROMISE Linux support team <support@promise.com.tw>
for their driver.  I have seen a working driver on a 20376 chip with just
one disk connected to it.

-Marcel

 > here: http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
> promise has got their own drivers. Have somebody seen
> this drivers really working? My card is not RAID,
> its only controller, I want only see the harddrives.
> Thanx a lot
>     Milan Roubal
> 
> ----- Original Message ----- 
> From: <Mitch@0Bits.COM>
> To: <linux-kernel@vger.kernel.org>
> Cc: <roubm9am@barbora.ms.mff.cuni.cz>
> Sent: Wednesday, July 09, 2003 3:16 PM
> Subject: Re: Promise SATA 150 TX2 plus
> 
> 
> > 
> > I believe that is the Promise PDC 20736 controller
> > for which there is no current driver yet. Search in
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&r=1&b=200307&w=2
> > 
> > for "20736" and read the thread(s) there.
> > 
> > Cheers
> > M
> > 
> > Milan Roubal wrote:
> > > Hi,
> > > I got one card SATA 150 TX2 plus with version v1.00.0.20 on chip.
> > > I want to make it working under SuSE linux 8.0. I have downloaded
> > > drivers from www.promise.com, but driver is not working, because of bad
> > > major/minor numbers of /dev/sda, /dev/sda1, /dev/sdb, .....
> > > What are the major/minor numbers for making it work?
> > >
> > > Or is there any other driver that I should use for making this card =
> > > working?
> > > What are major/minor numbers for that drivers?
> > > Thanks very much for your answers.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
