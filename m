Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSIIRVz>; Mon, 9 Sep 2002 13:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSIIRVz>; Mon, 9 Sep 2002 13:21:55 -0400
Received: from franka.aracnet.com ([216.99.193.44]:51171 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S317580AbSIIRVy>; Mon, 9 Sep 2002 13:21:54 -0400
Date: Mon, 09 Sep 2002 10:24:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>, Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <315901602.1031567059@[10.10.2.3]>
In-Reply-To: <E17oRol-0006pi-00@starship>
References: <E17oRol-0006pi-00@starship>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > An idea that's looking more and more attractive as time goes by is to
>> > have a global config option that specifies that we want to choose the
>> > simple way of doing things wherever possible, over the enterprise way.
>> > We want this especially for embedded.  On low end processors, it's even
>> > possible that the small way will be faster in some cases than the
>> > enterprise way, due to cache effects.
>> 
>> Can't we just use the existing config options instead? CONFIG_SMP is
>> a good start ;-) How many embedded systems with SMP do you have?
> 
> You need to look at it from the other direction: how do the needs of a
> uniprocessor Clawhammer box differ from a Linksys adsl router?

I wouldn't call uniprocessor Clawhammer the "enterprise way" type
machine. But other than that, I see your point. You're in a far 
better position to answer your own question than I am, so I'll leave 
that as rhetorical ;-)

M.

