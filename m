Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTLLQvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTLLQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:51:14 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:63457 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261311AbTLLQvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:51:11 -0500
Date: Fri, 12 Dec 2003 09:51:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] -tiny tree for small systems (2.6.0-test11)
Message-ID: <20031212165110.GR23731@stop.crashing.org>
References: <20031212033734.GG23787@waste.org> <20031212154443.GN23731@stop.crashing.org> <20031212155948.GK23787@waste.org> <20031212160508.GO23731@stop.crashing.org> <brcpmq$a2n$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <brcpmq$a2n$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:17:30PM +0000, bill davidsen wrote:
> In article <20031212160508.GO23731@stop.crashing.org>,
> Tom Rini  <trini@kernel.crashing.org> wrote:
> 
> | Well part of the problem that came up when this was brought up during
> | 2.5 is that adding a whole bunch of CONFIG options for things Just Won't
> | Happen (too complex, PITA, etc).  OTOH however, lots of stuff like that
> | keeps getting in.
> 
> But now we have a config section for disabling things which may not be
> needed in embedded systems. So there's a fair chance that tweaks and
> such can be accepted as long as they're in the area where most will
> never go.

That was the case at the time as well.

-- 
Tom Rini
http://gate.crashing.org/~trini/
