Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293639AbSCFQEX>; Wed, 6 Mar 2002 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293634AbSCFQEO>; Wed, 6 Mar 2002 11:04:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41222 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293633AbSCFQD5>; Wed, 6 Mar 2002 11:03:57 -0500
Date: Wed, 6 Mar 2002 11:01:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <3C85F872.7050306@evision-ventures.com>
Message-ID: <Pine.LNX.3.96.1020306105428.386A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Martin Dalecki wrote:

> 2. It convinced me that the current task-file interface in linux
>     is inadequate. So Alan please bear with me if your CF format
>     microdrive will have to not wakeup properly for some time...
>     The current mess will just have to go before something more
>     adequate can go in.

  Fortunately you have the 2.5 kernel to do just this type of thing,
and others who don't share the "it's not perfect, rewrite from scratch"
may be able to find a clean way to provide true RAW access for root."
 
> 3. Someone had too much time at apple, becouse the C++ found
>     there doesn't apparently contain anything that couldn't
>     be expressed without any pain in plain C with structs containing
>     function pointers ;-).

  Can't disagree, I never understood how people who can understand
inheritance can be fuddled by pointers to functions.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

