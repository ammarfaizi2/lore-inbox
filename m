Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284198AbRLASnh>; Sat, 1 Dec 2001 13:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284206AbRLASnU>; Sat, 1 Dec 2001 13:43:20 -0500
Received: from bitmover.com ([192.132.92.2]:38596 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284194AbRLASm7>;
	Sat, 1 Dec 2001 13:42:59 -0500
Date: Sat, 1 Dec 2001 10:42:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011201104238.A21766@work.bitmover.com>
Mail-Followup-To: Ricardo Galli <gallir@uib.es>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <E16AF2A-0002HG-00@linux.uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16AF2A-0002HG-00@linux.uib.es>; from gallir@uib.es on Sat, Dec 01, 2001 at 07:38:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 07:38:42PM +0100, Ricardo Galli wrote:
> > Amen to that. STREAMS would be one of the strongest arguments in favor
> > of Linus' theory that evolution takes care of it. STREAMS were done at
> > Sun by some "architects" who thought they would be better than sockets.
> 
> Wasn't Dennis Ritchie one of the "architects" of STREAMS at Bell Labs?
> 
>   A Stream Input-Output System : AT&T Bell Laboratories Technical Journal 
>   63,  No. 8 Part 2 (October, 1984)

Dennis wrote something called "streams" not be confused with "STREAMS".
He was trying to provide a more flexible mechanism for tty line 
disciplines.  The Sys III guys grabbed it and decided to promote it as 
a networking infrastructure, because System III et al did not have
networking.  Dennis doesn't like the result any better than any of us.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
