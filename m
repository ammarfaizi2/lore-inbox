Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSHGXPR>; Wed, 7 Aug 2002 19:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSHGXPR>; Wed, 7 Aug 2002 19:15:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47376 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315372AbSHGXPQ>; Wed, 7 Aug 2002 19:15:16 -0400
Date: Wed, 7 Aug 2002 19:12:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'mrproper'?
In-Reply-To: <20020807133217.GF32427@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.3.96.1020807191015.14463F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Matti Aarnio wrote:

>   Besides of the referral to domestic cleaning agent..
>   The "mrproper" tag is being used all over the place
>   to remove most of configuration and compilation related
>   files.
> 
>   "distclean" calls at first "mrproper", and then does some
>   additional cleanups, like various editor backup files.
> 
>   Thus "distclean" does more than "mrproper".

Yes, thanks, I see what it does, I was more wondering about the name (ok,
typical late night in-joke) and the need for a less complete cleaning. It
takes the same time as distclean, and requires the same steps, I was just
wondering at the need.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

