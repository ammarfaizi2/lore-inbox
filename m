Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317940AbSFSRBL>; Wed, 19 Jun 2002 13:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317941AbSFSRBL>; Wed, 19 Jun 2002 13:01:11 -0400
Received: from [213.23.20.58] ([213.23.20.58]:3222 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317940AbSFSRBJ>;
	Wed, 19 Jun 2002 13:01:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Date: Wed, 19 Jun 2002 19:00:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
In-Reply-To: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17KipF-0000up-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 13:18, Craig Kulesa wrote:
> Where:  http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/
>
> This patch implements Rik van Riel's patches for a reverse mapping VM 
> atop the 2.5.23 kernel infrastructure...
>
> ...Hope this is of use to someone!  It's certainly been a fun and 
> instructive exercise for me so far.  ;)

It's intensely useful.  It changes the whole character of the VM discussion 
at the upcoming kernel summit from 'should we port rmap to mainline?' to 'how 
well does it work' and 'what problems need fixing'.  Much more useful.

Your timing is impeccable.  You really need to cc Linus on this work, 
particularly your minimal, lru version.

-- 
Daniel

