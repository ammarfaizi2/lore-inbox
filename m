Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291245AbSBLXQ3>; Tue, 12 Feb 2002 18:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291250AbSBLXOc>; Tue, 12 Feb 2002 18:14:32 -0500
Received: from bitmover.com ([192.132.92.2]:18111 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291254AbSBLXOT>;
	Tue, 12 Feb 2002 18:14:19 -0500
Date: Tue, 12 Feb 2002 15:14:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020212151419.G25559@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	Ingo Molnar <mingo@elte.hu>, Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130092529.O23269@work.bitmover.com> <Pine.LNX.4.33L.0202122058150.12554-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0202122058150.12554-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Feb 12, 2002 at 08:59:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 08:59:34PM -0200, Rik van Riel wrote:
> One thing I noticed was that the space usage of all the
> bk trees I'm using in order to keep the different changes
> individually pullable is about 1.5 GB now.

We just need the "bk relink" command and that should be ~100M or so.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
