Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbSIYTi2>; Wed, 25 Sep 2002 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSIYTi1>; Wed, 25 Sep 2002 15:38:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10244 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262074AbSIYTiZ>; Wed, 25 Sep 2002 15:38:25 -0400
Date: Wed, 25 Sep 2002 12:46:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.44.0209252141080.17991-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209251246100.2836-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Ingo Molnar wrote:
> 
> i'd expect the 'Y' to be picked up from the defconfig - no?

No. defconfig is either used 100% or not at all.

		Linus

