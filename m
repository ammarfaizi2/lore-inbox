Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSIFHEf>; Fri, 6 Sep 2002 03:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSIFHEf>; Fri, 6 Sep 2002 03:04:35 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:1931 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S318300AbSIFHEe>;
	Fri, 6 Sep 2002 03:04:34 -0400
Date: Fri, 6 Sep 2002 09:09:11 +0200
From: bert hubert <ahu@ds9a.nl>
To: Daniel Phillips <phillips@arcor.de>
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
Message-ID: <20020906070911.GA31562@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Daniel Phillips <phillips@arcor.de>,
	Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20020904220055.21349.qmail@linuxmail.org> <20020905134830.GA16149@outpost.ds9a.nl> <E17n9im-0006Ef-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17n9im-0006Ef-00@starship>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 05:23:48AM +0200, Daniel Phillips wrote:
> On Thursday 05 September 2002 15:48, bert hubert wrote:
> > Arithmetic Test (type = arithoh)        3598100.4 lps    3435944.6 lps
> > Arithmetic Test (type = register)        201521.0 lps     197870.4 lps
> > Arithmetic Test (type = short)           190245.9 lps     145140.8 lps
> > Arithmetic Test (type = int)             201904.5 lps     104440.5 lps
> > Arithmetic Test (type = long)            201906.4 lps     177757.4 lps
> > Arithmetic Test (type = float)           210562.7 lps     208476.4 lps
> > Arithmetic Test (type = double)          210385.9 lps     208443.3 lps
> 
> What kind of arithmetic is this?  Why on earth would arithmetic vary
> from one kernel to another?

I wasn't involved in this benchmark, I just reformatted the results.
However, it might be that this benchmark is a tad braindead and 'suffers'
from far better timing resolution because of HZ=1000. I'm unsure. I saw that
this benchmark used something like a Sparcstation 5 as a reference platform,
so maybe it is not geared for today's processors.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
