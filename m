Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289829AbSBGR1E>; Thu, 7 Feb 2002 12:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBGR1A>; Thu, 7 Feb 2002 12:27:00 -0500
Received: from bitmover.com ([192.132.92.2]:15578 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289829AbSBGR0o>;
	Thu, 7 Feb 2002 12:26:44 -0500
Date: Thu, 7 Feb 2002 09:26:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207092640.P27932@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com>; from torvalds@transmeta.com on Thu, Feb 07, 2002 at 08:36:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 08:36:20AM -0800, Linus Torvalds wrote:
> > What about people who send you occasionnal patches, and happen to
> > be using Bitkeeper too ?
> 
> For those people, "bk send -d torvalds@transmeta.com" is fine. It ends up

No!  This will send the entire repository.  Do a "bk help send", you probably
want "bk send -d -r+ torvalds@transmeta.com" to send the most recent cset.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
