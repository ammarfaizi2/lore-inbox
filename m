Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313080AbSC0TKw>; Wed, 27 Mar 2002 14:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313078AbSC0TKn>; Wed, 27 Mar 2002 14:10:43 -0500
Received: from astrodienst.ch ([192.53.104.1]:44550 "EHLO as73.astro.ch")
	by vger.kernel.org with ESMTP id <S313071AbSC0TKf>;
	Wed, 27 Mar 2002 14:10:35 -0500
Date: Wed, 27 Mar 2002 20:10:33 +0100 (MET)
From: Alois Treindl <alois@astro.ch>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops with kjournald in SMP 2.4.16
In-Reply-To: <3CA203FA.262EB621@zip.com.au>
Message-ID: <Pine.HPX.4.21.0203272007400.20694-100000@as73.astro.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Andrew Morton wrote:
> 
> For a while we were seeing a lot of these.  Around 2.4.14 to 2.4.17.
> I have twenty or thirty different reports saved away.
> 
> But they seem to have stopped.  It's beginning to look like whatever
> it was got fixed somehow.
> 
> > 
> > Does anyone recognize this problem, and has it been fixed in later kernels?
> > 
> 
> Possibly so, yes.  2.4.16 is suspect in this regard.
> 

Thanks for replying.
It is pity the situation is not more clear. 

I understand you are saying hat the problem is not related to
kjournald/ext3.


