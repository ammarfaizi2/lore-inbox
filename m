Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316432AbSEOQ0H>; Wed, 15 May 2002 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316433AbSEOQ0G>; Wed, 15 May 2002 12:26:06 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36752 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S316432AbSEOQ0F>;
	Wed, 15 May 2002 12:26:05 -0400
Date: Wed, 15 May 2002 18:26:06 +0200
From: bert hubert <ahu@ds9a.nl>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Andre LeBlanc <ap.leblanc@shaw.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody (Long Message)
Message-ID: <20020515162606.GB2810@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Andre LeBlanc <ap.leblanc@shaw.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox> <20020514202912.GA18544@outpost.ds9a.nl> <000c01c1fba2$1779da60$2000a8c0@metalbox> <1021478231.17761.0.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 05:57:10PM +0200, Xavier Bestel wrote:
> Le mer 15/05/2002 ? 01:50, Andre LeBlanc a ?crit :
> > 
> > I also noticed that when booting, the 2.2.20 kernel identifies media type
> > 100MBit Full duplex, and under 2.4.19-pre8 it detects 10MBit half duplex.,
> > if that makes a difference
> 
> Same thing here. I'm really interested why.

Oh, regarding tcpdump, make sure you use 'tcpdump -n', otherwise the reverse
lookup might block your output!

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
