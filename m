Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUBBRff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbUBBRfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:35:34 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:2418 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265729AbUBBRfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:35:33 -0500
Date: Mon, 2 Feb 2004 17:37:19 +0000
From: DaMouse Networks <damouse@ntlworld.com>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Crazy idea: Design open-source graphics chip
Message-Id: <20040202173719.52952f7f@EozVul.WORKGROUP>
In-Reply-To: <401E85EA.7010209@techsource.com>
References: <20040201145827.059332d3@EozVul.WORKGROUP>
	<401E85EA.7010209@techsource.com>
Organization: DaMouse Networks
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Feb 2004 12:16:26 -0500
Timothy Miller <miller@techsource.com> wrote:

> 
> 
> DaMouse Networks wrote:
> >>A cheap cludge would be an optional second GPU on the card just to do
> >>the required VGA modes, with an analogue video pass-through. That
> >>would make the VGA cards more expensive than a single GPU which
> >>incorporated VGA, but add almost nothing in cost or complexity terms
> >>to the non-VGA cards.
> > 
> > 
> > I was thinking of suggesting something similar as I browsed the thread. I would think that having Linux instead of the BIOS would be good since you would only need a small cut-down Linux that has drivers for a VGA->FB interface or something similar. The SMP approach from XGI might work in this since Linux supports SMP very well and  it could perform well with up to like 4+ GPUs? (thinking of the card size that might limit this you could have them stacked :) )
> > 
> > I think I'm gonna have to follow this thread closely :)
> 
> 
> So, do you all honestly think that adding cost to the board is going to 
> make it sell?
> 

More cost? how is saving money on the BIOS raising cost? also the SMP thing would allow like a ton of cheap chips to be stuck on with uber glue :)

-DaMouse
