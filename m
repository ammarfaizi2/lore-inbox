Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318469AbSHKXrq>; Sun, 11 Aug 2002 19:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318472AbSHKXrq>; Sun, 11 Aug 2002 19:47:46 -0400
Received: from bitmover.com ([192.132.92.2]:47306 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318469AbSHKXrp>;
	Sun, 11 Aug 2002 19:47:45 -0400
Date: Sun, 11 Aug 2002 16:50:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
Message-ID: <20020811165003.F17310@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>, frankeh@watson.ibm.com,
	davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
	"David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
	Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <1029113179.16236.101.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44L.0208112041110.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0208112041110.23404-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Aug 11, 2002 at 08:42:16PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 08:42:16PM -0300, Rik van Riel wrote:
> On 12 Aug 2002, Alan Cox wrote:
> 
> > Unfortunately the USA forces people to deal with this crap. I'd hope SGI
> > would be decent enough to explicitly state they will license this stuff
> > freely for GPL use
> 
> I seem to remember Apple having a clause for this in
> their Darwin sources, forbidding people who contribute
> code from suing them about patent violations due to
> the code they themselves contributed.

IBM has a fantastic clause in their open source license.  The license grants
you various rights to use, etc., and then goes on to say something in 
the termination section (I think) along the lines of 

	In the event that You or your affiliates instigate patent, trademark,
	and/or any other intellectual property suits, this license terminates
	as of the filing date of said suit[s].

You get the idea.  It's basically "screw me, OK, then screw you too" language.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
