Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbRFUUVB>; Thu, 21 Jun 2001 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265195AbRFUUUv>; Thu, 21 Jun 2001 16:20:51 -0400
Received: from mail.efore.fi ([62.236.103.42]:48132 "EHLO maxwell.efore.fi")
	by vger.kernel.org with ESMTP id <S265194AbRFUUUk>;
	Thu, 21 Jun 2001 16:20:40 -0400
Message-ID: <3B3256C2.D951B990@efore.fi>
Date: Thu, 21 Jun 2001 23:19:14 +0300
From: Lauri Tischler <lauri.tischler@efore.fi>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Henningsen <kaih@khms.westfalen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
In-Reply-To: <OFE74ECCAE.A9CB9437-ON80256A72.0045BC45@portsmouth.uk.ibm.com> <3B32280A.ADC08780@efore.fi> <83JvUAC1w-B@khms.westfalen.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Henningsen wrote:
> 
> lauri.tischler@efore.fi (Lauri Tischler)  wrote on 21.06.01 in <3B32280A.ADC08780@efore.fi>:
> 
> > Richard J Moore wrote:
> > >
> > > > 59.42886726469 ±2°C is obviously ludicrous, even if that's
> > > > what my calculator gives me.  I should instead write 59 ±2°C, since
> > >
> > > So, if I follow you argument then shouldn't you be writing 58 ±2°C or
> > > should it be 60 ±2°C ?
> >
> > What it means is that whatever dingus measured the temperature, reported
> > the temperature as 59C.
> 
> Well, maybe. And maybe it reported the temperature as "76 units", where a
> unit is approximately 0.69°C, and zero units are approximately 6.99°C, and
> we happen to know the accuracy is 3 units.
> 
> (That makes out to 59.43 ±2.07°C, or 57.36 to 61.50°C, whereas 59 ±2°C
> works out to 57.00 to 61.00°C - they do overlap, but they're not the same.
> Now you might not care - but then again, you might care

Oh, shit.  +-2C means NO decimals
Any decimal you care to put there are meaningless.
..unless you do integration over extended period of time etc.. etc..
even then if your sensor only gives +-2C diff's  ??

-- 
lauri.tischler@iki.fi * Man created god as His image *
                      *  Man has horrid imagination  *

