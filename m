Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268245AbTGINUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbTGINUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:20:21 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:41713 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S268245AbTGINUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:20:18 -0400
Message-ID: <027901c3461e$e023c670$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <Mitch@0Bits.COM>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com>
Subject: Re: Promise SATA 150 TX2 plus
Date: Wed, 9 Jul 2003 15:34:51 +0200
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

Thanks for the answer, it has got PDC 20375, not
20376, but it changes nothing. As Alan mentioned
here: http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
promise has got their own drivers. Have somebody seen
this drivers really working? My card is not RAID,
its only controller, I want only see the harddrives.
Thanx a lot
    Milan Roubal

----- Original Message ----- 
From: <Mitch@0Bits.COM>
To: <linux-kernel@vger.kernel.org>
Cc: <roubm9am@barbora.ms.mff.cuni.cz>
Sent: Wednesday, July 09, 2003 3:16 PM
Subject: Re: Promise SATA 150 TX2 plus


> 
> I believe that is the Promise PDC 20736 controller
> for which there is no current driver yet. Search in
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&r=1&b=200307&w=2
> 
> for "20736" and read the thread(s) there.
> 
> Cheers
> M
> 
> Milan Roubal wrote:
> > Hi,
> > I got one card SATA 150 TX2 plus with version v1.00.0.20 on chip.
> > I want to make it working under SuSE linux 8.0. I have downloaded
> > drivers from www.promise.com, but driver is not working, because of bad
> > major/minor numbers of /dev/sda, /dev/sda1, /dev/sdb, .....
> > What are the major/minor numbers for making it work?
> >
> > Or is there any other driver that I should use for making this card =
> > working?
> > What are major/minor numbers for that drivers?
> > Thanks very much for your answers.
