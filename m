Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbSIYTky>; Wed, 25 Sep 2002 15:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbSIYTky>; Wed, 25 Sep 2002 15:40:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52362 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262076AbSIYTkx>;
	Wed, 25 Sep 2002 15:40:53 -0400
Date: Wed, 25 Sep 2002 21:54:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.33.0209251246100.2836-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209252154010.18654-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Linus Torvalds wrote:

> > i'd expect the 'Y' to be picked up from the defconfig - no?
> 
> No. defconfig is either used 100% or not at all.

hm, then what is the standard way to make a new kernel option default-Y?  
At least for the development kernel, a default-enabled kksymoops sounds
like the right way to go.

	Ingo

