Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSBZXLa>; Tue, 26 Feb 2002 18:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSBZXLU>; Tue, 26 Feb 2002 18:11:20 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:52099 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S287552AbSBZXLP>;
	Tue, 26 Feb 2002 18:11:15 -0500
Subject: Re: Congrats Marcelo,
From: Steve Lord <lord@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16f8Ey-0002qn-00@starship.berlin>
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com>
	<20020226140644.U12832@lynx.adilger.int>
	<1014760581.5993.159.camel@jen.americas.sgi.com> 
	<E16f8Ey-0002qn-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 17:07:32 -0600
Message-Id: <1014764852.9994.191.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-02-24 at 17:39, Daniel Phillips wrote:
> 
> I'd really like to see XFS go in, but don't you think 2.5 is the place,
> with a view to 2.4 submission in due course?

This is my thinking, but the way 2.5 is diverging the argument that
xfs being stable in 2.5 prior to going into 2.4 probably will not mean
too much at the end of the day since the interfaces will probably
have diverged so much by then - and the interfaces are where the
nasties tend to come out. The core of XFS is pretty darn stable.

> 
> As far as making the case goes, do you have time to make a list of
> places where XFS goes outside fs/xfs, and why?

I have had about 20 emails since I got yours ;-) One of the reasons
I have not been attempting to submit XFS is that I have too many 
other things going on right now, hopefully things are getting 
quieter and I can take a shot at this again. I will see how tomorrow
goes ....

Steve

> 
> -- 
> Daniel
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
