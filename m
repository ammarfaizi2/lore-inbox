Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUCPXRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCPXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:17:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:15580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261802AbUCPXRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:17:14 -0500
Message-Id: <200403162317.i2GNH8E27020@mail.osdl.org>
Date: Tue, 16 Mar 2004 15:17:01 -0800 (PST)
From: markw@osdl.org
Subject: Re: lvm2 performance data with linux-2.6
To: davidsen@tmr.com
cc: linux-kernel@vger.kernel.org
In-Reply-To: <c37sco$fko$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Mar, bill davidsen wrote:
> In article <20040311142515.A27177@osdlab.pdx.osdl.net>,
> Mark Wong  <markw@osdl.org> wrote:
> | On Thu, Mar 11, 2004 at 05:12:35PM -0500, Bill Davidsen wrote:
> 
> | > Here's one thought: look at the i/o rates on individual drives using 
> | > each stripe size. You *might* see that one size does far fewer seeks 
> | > than others, which is a secondary thing to optimize after throughput IMHO.
> | > 
> | > If you don't have a tool for this I can send you the latest diorate 
> | > which does stuff like this, io rate perdrive or per partition, something 
> | > I occasionally find revealing.
> | 
> | Yeah, please do send me a copy.  I'd be interested to see what that might 
> | turn up.  I've just been using iostat -x so far.
> 
> Okay, I posted the pointer a few days ago to LKML, did you get a chance
> to try it? And if so, did it tell you anything?

I've grabbed it but I haven't had a chance to try it yet.  Hopefully
later today or tomorrow.

Mark
