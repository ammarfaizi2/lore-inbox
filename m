Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSFKATw>; Mon, 10 Jun 2002 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSFKATv>; Mon, 10 Jun 2002 20:19:51 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:38865 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316577AbSFKATv>; Mon, 10 Jun 2002 20:19:51 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Paul Menage <pmenage@ensim.com>
Subject: Re: netlink documentation (was: of ethernet names)
Date: Tue, 11 Jun 2002 10:16:59 +1000
User-Agent: KMail/1.4.5
Cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E17HZBU-0000Jm-00@pmenage-dt.ensim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206111016.59260.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 10:06, Paul Menage wrote:
> >But I can't even follow enough of iproute (or zebra, which also uses
> > netlink, AFAICT) to figure out how to do basic stuff like a list of
> > configured networking devices, or set the default route.
>
> E.g. to get the list of devices (untested, lacking error checking, etc),
> use something like:
Bingo! I think I see what is happening, just by inspection. Beverage of choice 
when we meet up!

Now, how did you get this? Just familarity with the API built up over time, 
pure zen, or copied from some other app?

A couple of days of playing with this, I might even be able to write the 
tutorial myself :)

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
