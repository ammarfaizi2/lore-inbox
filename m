Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbTAOQzl>; Wed, 15 Jan 2003 11:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTAOQzl>; Wed, 15 Jan 2003 11:55:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6040 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266730AbTAOQzj>;
	Wed, 15 Jan 2003 11:55:39 -0500
Message-Id: <200301151704.h0FH4Rn08640@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Ian Wienand <ianw@gelato.unsw.edu.au>
cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>,
       Cliff White <cliffw@osdl.org>, cliffw@osdl.org
Subject: Re: [ANNOUNCE] contest benchmark v0.60 
In-Reply-To: Message from Ian Wienand <ianw@gelato.unsw.edu.au> 
   of "Wed, 15 Jan 2003 15:15:24 +1100." <20030115041524.GE21742@cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Jan 2003 09:04:27 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 15, 2003 at 02:16:48PM +1100, Con Kolivas wrote:
> > Ok some mildly annoying bugs have already shown up in this release.
> > 
> > I've put up a contest-0.61pre on the contest website that addresses the one 
> > which ruins the results and has some of the changes going into 0.61
> 
> Con/Aggelos,
> 
> What was the motivation for re-writing in C?
> 
> I've done some hacking on the old version here, and so I realise that
> such a big shell script was getting a little out of hand, but surely
> perl or python is a better option for this application?
> 
> If it's going to stay in C maybe we could integrate profiling support
> from /proc/profile, bypassing readprofile?  One of the guys here
> recently wanted to get profiling information from his program, and it
> would have been really good to have a library that could reset, start,
> pause and return in some format the profiling data.  If you think your
> users might be interested in profile outputs I can write something
> maybe we can both use.
> 

I'd be very interested in learning more about getting profile support in things
Might come in very handy for AIM7. 
cliffw
OSDL


> -i
> ianw@gelato.unsw.edu.au
> http://www.gelato.unsw.edu.au
> 


