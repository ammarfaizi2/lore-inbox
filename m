Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292983AbSCKVBp>; Mon, 11 Mar 2002 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293013AbSCKVBf>; Mon, 11 Mar 2002 16:01:35 -0500
Received: from bitmover.com ([192.132.92.2]:38320 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292983AbSCKVBY>;
	Mon, 11 Mar 2002 16:01:24 -0500
Date: Mon, 11 Mar 2002 13:01:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>,
        "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020311130122.C26447@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	"Jonathan A. George" <JGeorge@greshamstorage.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020311090512.N26447@work.bitmover.com> <Pine.LNX.4.44L.0203111731420.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0203111731420.2181-100000@imladris.surriel.com>; from riel@conectiva.com.br on Mon, Mar 11, 2002 at 05:36:23PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 05:36:23PM -0300, Rik van Riel wrote:
> ... and I prefer the one which is chosen with 'f2', nothing beats
> the [left] [right] buttons!

Hah.  Try the bk-2.1.x series and try the 3way filemerge.  The two way stuff
is nice, and I use it all the time for simple stuff, but when things get
nasty, the 3way filemerge is just amazingly good.  You have to invest more
time to learn it because it is showing you more information, but our
customers have one by one moved over to it and would scream bloody murder
if we took it away, it's a huge timesaver.

The fact that you can get by with the 2way merge says that the merges you
are doing are easy.  When they get harder, you'll need better tools.  It's
cool that 2way works for you, but it's more cool that when it doesn't, we
already have the next level implemented.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
