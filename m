Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSGGVxP>; Sun, 7 Jul 2002 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSGGVxO>; Sun, 7 Jul 2002 17:53:14 -0400
Received: from pD952A04C.dip.t-dialin.net ([217.82.160.76]:16080 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316586AbSGGVxO>; Sun, 7 Jul 2002 17:53:14 -0400
Date: Sun, 7 Jul 2002 15:55:43 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dave Hansen <haveblue@us.ibm.com>
cc: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BKL removal
In-Reply-To: <3D28B423.9060903@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Jul 2002, Dave Hansen wrote:
>   "As long as I comment [and understand] why I am using the BKL." 
> would be a bit more accurate.  How many places in the kernel have you 
> seen comments about what the BKL is actually doing?  Could you point 
> me to some of your comments where _you_ are using the BKL?  Once you 
> fully understand why it is there, the extra step of removal is usually 
> very small.

Old Blue, could you please bring me an example on where in USB the bkl 
shouldn't be used, but is? And can you explain why it's wrong to use bkl
there?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

