Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262867AbRE3WZu>; Wed, 30 May 2001 18:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbRE3WZf>; Wed, 30 May 2001 18:25:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55817 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262858AbRE3WZJ>; Wed, 30 May 2001 18:25:09 -0400
Date: Wed, 30 May 2001 17:48:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reclaim dirty dead swapcache pages
In-Reply-To: <20010531001537.G1138@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0105301743100.5231-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 May 2001, J . A . Magallon wrote:

> 
> On 05.30 Marcelo Tosatti wrote:
> > 
> > 
> > Its at
> > http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.5ac4/reapswap.patch
> > 
> > Please test. 
> > 
> 
> Which kind of test, something like the gcc think I posted recently ?

I don't remember that, sorry. What was it again? 

> Just stress vm, fill swap, and try to do it again ?

For example.

I would _prefer_ tests non artifical tests, though. (ie not the kind of
workloads where tasks are trying to consume all available resources all
the time)

Still, any kind of report is welcome, of course. 

Thanks a lot! 

