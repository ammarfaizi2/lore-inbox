Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271648AbRIBRZV>; Sun, 2 Sep 2001 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271649AbRIBRZB>; Sun, 2 Sep 2001 13:25:01 -0400
Received: from mx9.port.ru ([194.67.57.19]:30349 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S271648AbRIBRYy>;
	Sun, 2 Sep 2001 13:24:54 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109022146.f82LkS904034@-f>
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 2 Sep 2001 21:46:27 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010902165742Z16375-32383+3005@humbolt.nl.linux.org> from "Daniel Phillips" at Sep 02, 2001 07:04:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Daniel Phillips wrote:
> > One thing that goes away with rmaps is the need to scan process page tables.
> It's possible that this takes enough load off L1 cache to produce the effects
    I feel like that. 
    actually there was a fear that the overhead of reverse map maintenance
 will overthrow the gain on low loads, but in my case this isnt an issue.
> you showed, though it would be surprising.
> 
> (Note that I'm in the "reverse maps are good" camp, and I think Rik's design 
> is fundamentally correct.)
    me too...
> 
> --
> Daniel
> 

