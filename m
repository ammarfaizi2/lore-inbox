Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316444AbSEORIb>; Wed, 15 May 2002 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316445AbSEORIa>; Wed, 15 May 2002 13:08:30 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:4387 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S316444AbSEORIa>; Wed, 15 May 2002 13:08:30 -0400
Date: Wed, 15 May 2002 12:31:37 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody (Long
 Message)
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Message-id: <001501c1fc47$2172e520$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox>
 <20020514202912.GA18544@outpost.ds9a.nl>
 <000c01c1fba2$1779da60$2000a8c0@metalbox> <1021478231.17761.0.camel@bip>
 <20020515162606.GB2810@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tcpdump isn't installed on my system.. :(

and i can't download it without a network connection...



> On Wed, May 15, 2002 at 05:57:10PM +0200, Xavier Bestel wrote:
> > Le mer 15/05/2002 ? 01:50, Andre LeBlanc a ?crit :
> > >
> > > I also noticed that when booting, the 2.2.20 kernel identifies media
type
> > > 100MBit Full duplex, and under 2.4.19-pre8 it detects 10MBit half
duplex.,
> > > if that makes a difference
> >
> > Same thing here. I'm really interested why.
>
> Oh, regarding tcpdump, make sure you use 'tcpdump -n', otherwise the
reverse
> lookup might block your output!
>
> Regards,
>
> bert hubert
>
> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

