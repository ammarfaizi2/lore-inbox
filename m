Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290811AbSAaBn6>; Wed, 30 Jan 2002 20:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290831AbSAaBnn>; Wed, 30 Jan 2002 20:43:43 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:13586 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S290828AbSAaBnU>;
	Wed, 30 Jan 2002 20:43:20 -0500
Date: Wed, 30 Jan 2002 18:43:18 -0700
From: Val Henson <val@nmt.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130184318.K16371@boardwalk>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 11:48:05PM -0800
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> 
> One thing intrigued me in this thread - which was not the discussion
> itself, but the fact that Rik is using bitkeeper.
> 
> How many other people are actually using bitkeeper already for the kernel?
> I know the ppc guys have, for a long time, but who else is? bk, unlike
> CVS, should at least be _able_ to handle a "network of people" kind of
> approach.

I'm one of the ppc people so I don't really count, but...

I've used bitkeeper for the kernel for a year now.

One of the issues in the "network of people" approach is how much time
and effort it takes to maintain a separate tree while waiting for
changes to be merged into the main tree.  Bitkeeper really helps here.
I've been maintaining a tree with significant differences from the
mainline linuxppc tree, and I can pull and merge new changes without
hand-editing a file 99% of the time.  Maintaining my own tree is now a
minor annoyance, instead of a major pain.

-VAL
