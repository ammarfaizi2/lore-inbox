Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSFJWFx>; Mon, 10 Jun 2002 18:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316435AbSFJWFw>; Mon, 10 Jun 2002 18:05:52 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:34951 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S316434AbSFJWFw>; Mon, 10 Jun 2002 18:05:52 -0400
Date: Mon, 10 Jun 2002 15:02:05 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Bill Davidsen <davidsen@tmr.com>
cc: Olivier Galibert <galibert@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MTU discovery
In-Reply-To: <Pine.LNX.3.96.1020610174357.23851D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0206101453270.767-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


9000 is the limit on gigabit ethernet, other media type have different 
maximum frame sizes (ie 4470 on fddi, 9216 on pos oc12 interfaces). 

On Mon, 10 Jun 2002, Bill Davidsen wrote:

> On Mon, 10 Jun 2002, Olivier Galibert wrote:
> 
> > On Mon, Jun 10, 2002 at 11:05:13AM +0300, Matti Aarnio wrote:
> > >   Some devices do, however, support reception (and transmit) of what
> > >   is called "jumbograms".  With boomerang you can set a register
> > >   to contain the limit value.  Alternatively with boomerang, and
> > >   its predecessors, you can set a bit to accept extra-large frames.
> > > 
> > >   I recall the ultimate limit is in order of 4kB.
> > 
> > Actually, in my experience jumbograms are usually 9000 bytes.
> 
> To assist in searching for info, I've also seen the terms "jumbo packets"
> and "jumbo frames." 
> 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


