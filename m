Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSBZXXu>; Tue, 26 Feb 2002 18:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSBZXXk>; Tue, 26 Feb 2002 18:23:40 -0500
Received: from sleet.ispgateway.de ([62.67.200.125]:9618 "HELO
	sleet.ispgateway.de") by vger.kernel.org with SMTP
	id <S288086AbSBZXX0>; Tue, 26 Feb 2002 18:23:26 -0500
Message-ID: <3C7C18EB.4090509@ellinger.de>
Date: Wed, 27 Feb 2002 00:23:23 +0100
From: Rainer Ellinger <rainer@ellinger.de>
Organization: Rainers Rechenzentrum
User-Agent: Mozilla/5.0
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Steve Lord <lord@sgi.com>, Andreas Dilger <adilger@turbolabs.com>,
        "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com> <20020226140644.U12832@lynx.adilger.int> <1014760581.5993.159.camel@jen.americas.sgi.com> <E16f8Ey-0002qn-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> I'd really like to see XFS go in, but don't you think 2.5 is the place,
> with a view to 2.4 submission in due course?

In my opinion the main problem behind the originating note is the big difference between the mainline "linus" kernel and what 
people really need or are really using. And this might be also a problem for development. Take distribution vendor kernels: make a 
diff of your favorite distribution kernel and the vanilla one and think about it. SuSE allows a detailed look inside at 
ftp://ftp.suse.com/pub/people/mantel/next/patches-2.4.18-0.tar.bz2

I think development in 2.5 should focus on including this waiting patches and come to a end and release asap. I think it's more 
important to catch up with real world needs and existing patches, than working on new developments.

> As far as making the case goes, do you have time to make a list of
> places where XFS goes outside fs/xfs, and why?

For me ftp://oss.sgi.com/projects/xfs/download/patches/2.4.17/README does it. ;-)

-- 
rainer@ellinger.de

