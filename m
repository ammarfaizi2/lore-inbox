Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUBAO5C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 09:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUBAO5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 09:57:02 -0500
Received: from mta04-svc.ntlworld.com ([62.253.162.44]:23772 "EHLO
	mta04-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265327AbUBAO5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 09:57:00 -0500
Date: Sun, 1 Feb 2004 14:58:27 +0000
From: DaMouse Networks <damouse@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Crazy idea: Design open-source graphics chip
Message-Id: <20040201145827.059332d3@EozVul.WORKGROUP>
Organization: DaMouse Networks
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A cheap cludge would be an optional second GPU on the card just to do
> the required VGA modes, with an analogue video pass-through. That
> would make the VGA cards more expensive than a single GPU which
> incorporated VGA, but add almost nothing in cost or complexity terms
> to the non-VGA cards.

I was thinking of suggesting something similar as I browsed the thread. I would think that having Linux instead of the BIOS would be good since you would only need a small cut-down Linux that has drivers for a VGA->FB interface or something similar. The SMP approach from XGI might work in this since Linux supports SMP very well and  it could perform well with up to like 4+ GPUs? (thinking of the card size that might limit this you could have them stacked :) )

I think I'm gonna have to follow this thread closely :)

-DaMouse
