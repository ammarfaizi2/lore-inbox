Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSE2UuH>; Wed, 29 May 2002 16:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSE2UuG>; Wed, 29 May 2002 16:50:06 -0400
Received: from stingr.net ([212.193.32.15]:1459 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S315487AbSE2UuF>;
	Wed, 29 May 2002 16:50:05 -0400
Date: Thu, 30 May 2002 00:50:05 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
Message-ID: <20020529205005.GN422@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205291519270.9971-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Kai Germaschewski:
> There is still quite a bit left to do (in particular improving
> dependency generation and modversions handling), but I think it makes
> sense to explain what happened so far.
> 
> There's also some points (marked with >>>) where I'd like to get
> feedback on how things should be handled in the future.

May I ask you just one questin?
Have you read (yet) kbuild25 ?

Ahh, no, another one.
Is this a "signs" of kbuild25 being thrown away like cml2 ?
If yes, then I am very unhappy person now (c) ac

Played with kbuild25 today I migrated 2.4.19-pre8-ac5-s2 to it. Now make -f
Makefile-2.5 is a preferred way to make here. New system is much cleaner,
and don't need that mess of makedep and listmultis. But hey, people you
should already know that whilst you trying to install a couple of new nails
to rotten construct to help it stay for another couple of time intervals ...

:(((


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
